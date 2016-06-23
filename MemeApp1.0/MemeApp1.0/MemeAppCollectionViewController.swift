//
//  MemeAppCollectionViewController.swift
//  MemeApp1.0
//
//  Created by Akshay Iyer on 6/22/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MemeAppCollectionViewController: UICollectionViewController
{
    @IBOutlet var appCollection: UICollectionView!
 
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        appCollection.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeAppCollectionViewCell", forIndexPath: indexPath) as! MemeAppCollectionViewCell
        let meme = appDelegate.memes[indexPath.row]
        cell.imageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController")
        let memeDetailVC = object as! MemeDetailViewController
       
        //Populate View Controller with the data from the selected item
        memeDetailVC.memeDetail = appDelegate.memes[indexPath.row]
        print(memeDetailVC.memeDetail);
        
        //
        navigationController?.pushViewController(memeDetailVC, animated: true)
        
    }
    
}
