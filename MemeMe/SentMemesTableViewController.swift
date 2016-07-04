//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: Properties
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    
    
    
    // MARK: Table View Functions
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListTableViewCell
        let meme = memes[indexPath.row]
        
        cell.topLabel.text = meme.topText
        cell.bottomLabel.text = meme.bottomText
        cell.memedImage.image = meme.image
        cell.formatLabel(cell.topImageLabel, defaultText: meme.topText)
        cell.formatLabel(cell.bottomImageLabel, defaultText: meme.bottomText)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.row]
        
        let object: MemeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! MemeDetailViewController
        object.meme = meme
        
        navigationController!.pushViewController(object, animated: true)
        
    }
    
}
