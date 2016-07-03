//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
        print(memes)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListTableViewCell
        let meme = memes[indexPath.row]
        
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        cell.memedImage.image = meme.memedImage
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
