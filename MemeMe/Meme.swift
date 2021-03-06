//
//  Meme.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/1/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String = ""
    var bottomText: String = ""
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}