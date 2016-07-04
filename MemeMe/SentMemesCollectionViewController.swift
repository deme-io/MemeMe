//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimensionWidth = (view.frame.size.width - (2 * space)) / 3.0
        let dimensionHeight = (view.frame.size.height - (2 * space)) / 6.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimensionWidth, dimensionHeight)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView?.reloadData()
    }
    
    
    
    
    // MARK: Collection View Functions
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        let meme = memes[indexPath.item]
        
        cell.formatLabel(cell.topLabel, defaultText: meme.topText)
        cell.formatLabel(cell.bottomLabel, defaultText: meme.bottomText)
        cell.memeImageView.image = meme.image
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = memes[indexPath.item]
        
        let object: MemeDetailViewController = storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! MemeDetailViewController
        object.meme = meme
        
        navigationController!.pushViewController(object, animated: true)
    }
    
}

    