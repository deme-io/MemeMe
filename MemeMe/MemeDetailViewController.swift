//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var memedImage: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memedImage.image = meme.memedImage
    }

}
