//
//  Meme.swift
//  MemeApp1.0
//
//  Created by Akshay Iyer on 6/22/16.
//  Copyright © 2016 akshaytiyer. All rights reserved.
//

import UIKit

struct Meme {
        var topTextField: String
        var bottomTextField: String
        var currentImage: UIImage
        var memedImage: UIImage
    
    
    init(topTextField: String, bottomTextField: String, currentImage: UIImage, memedImage: UIImage) {
        self.topTextField = topTextField
        self.bottomTextField = bottomTextField
        self.currentImage = currentImage
        self.memedImage = memedImage
    }
}
