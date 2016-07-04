//
//  CollectionViewCell.swift
//  MemeMe
//
//  Created by Demetrius Henry on 7/3/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 12)!,
        NSStrokeWidthAttributeName : -3.6
    ]
    
    func formatLabel(label: UILabel, defaultText: String) {
        //label.textAlignment = NSTextAlignment.Center
        label.attributedText = NSAttributedString.init(string: defaultText, attributes: memeTextAttributes)
        //label.text = defaultText
    }
}
