//
//  MemeDetailViewController.swift
//  MemeApp1.0
//
//  Created by Akshay Iyer on 6/23/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController
{
    var memeDetail: Meme!
    @IBOutlet var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(self.memeDetail)
        imageView.image = self.memeDetail.memedImage
    }
    
}
