//
//  MemeViewController.swift
//  MemeApp1.0
//
//  Created by Akshay Iyer on 6/11/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var topToolbar: UIToolbar!
    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var imagePickerView: UIImageView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var shareButton: UIBarButtonItem!
    var memedImage: UIImage!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //The top text field
        textFieldAttributes(topTextField, defaultText: "TOP")
        //The bottom text field
        textFieldAttributes(bottomTextField, defaultText: "BOTTOM")
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardWillHideNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotifications()
        self.unsubscribeToKeyboardWillHideNotifications()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldAttributes(textField: UITextField, defaultText: String)
    {
        textField.text = defaultText
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }
    
    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeToKeyboardWillHideNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //Of CG Rect
        if bottomTextField.editing
        {
            return keyboardSize.CGRectValue().height
        }
        else
        {
            return 0
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("Picked")
        if let image=info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        shareButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Cancelled")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save(memedImage: UIImage) {
        //Create the meme
        let meme = Meme(topTextField: topTextField.text!, bottomTextField: bottomTextField.text!, currentImage: imagePickerView.image!, memedImage: memedImage)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print(appDelegate.memes.count)
    }
    
    func generateMemedImage() -> UIImage
    {
        // Render view to an image
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        return memedImage
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func shareImage(sender: AnyObject) {
        var shareableImage: UIImage!
        shareableImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [shareableImage], applicationActivities: [])
        activityViewController.completionWithItemsHandler = {
            (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                self.save(shareableImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        sourceType("PhotoLibrary")
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        sourceType("Camera")
    }
    
    func sourceType(name: String)
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        if name == "Camera"
        {
            pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else
        {
            pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
}

