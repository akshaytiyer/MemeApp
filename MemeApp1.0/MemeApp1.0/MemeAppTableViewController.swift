//
//  MemeAppTableViewController.swift
//  MemeApp1.0
//
//  Created by Akshay Iyer on 6/22/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MemeAppTableViewController: UITableViewController
{
    @IBOutlet var appData: UITableView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appData.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        appData.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeAppTableViewController", forIndexPath: indexPath)
        let meme = appDelegate.memes[indexPath.row]
        
        cell.textLabel?.text = meme.topTextField
        cell.detailTextLabel?.text = meme.bottomTextField
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
        let memeDetailVC = object as! MemeDetailViewController
        
        memeDetailVC.memeDetail = appDelegate.memes[indexPath.row]
        
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
}
