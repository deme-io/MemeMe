//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
}
