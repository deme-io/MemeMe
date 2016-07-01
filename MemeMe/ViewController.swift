//
//  ViewController.swift
//  MemeMe
//
//  Created by Demetrius Henry on 2/21/16.
//  Copyright © 2016 Demetrius Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    // MARK: Properties
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var topEditCount = 0
    var bottomEditCount = 0
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 4
    ]
    
    
    struct Meme {
        let textField1: String
        let textField2: String
        let image: UIImage
        let memedImage: UIImage
    }
    
    
    
    
    

    // MARK: Default Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formatTextField(topTextField, defaultText: "TOP")
        topTextField.tag = 0
        
        self.formatTextField(bottomTextField, defaultText: "BOTTOM")
        bottomTextField.tag = 1
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        subscribeToKeyboardNotifications()
        
        if imagePickerView.image == nil {
            shareButton.enabled = false
        } else {
            shareButton.enabled = true
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    
    
    
    
    // MARK: Image Functions
    
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        self.presentImagePicker(.PhotoLibrary)
    }
    
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        self.presentImagePicker(.Camera)
    }
    
    
    func presentImagePicker(chosenSource: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = chosenSource
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    // MARK: TextField Functions
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag == 0 {
            if topEditCount == 0 {
                textField.text = ""
                topEditCount = topEditCount + 1
            }
        } else if textField.tag == 1 {
            if bottomEditCount == 0 {
                textField.text = ""
                bottomEditCount = topEditCount + 1
            }
        }
    }
    
    
    func formatTextField(textField: UITextField, defaultText: String) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.text = defaultText
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    // MARK: Keyboard Functions
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    
    
    
    
    
    // MARK: Generate and Save Meme Functions
    
    func save() {
        _ = Meme.init(textField1: self.topTextField.text!, textField2: self.bottomTextField.text!, image: self.imagePickerView.image!, memedImage: self.generateMemedImage())
    }
    
    
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController?.navigationBarHidden = false
        
        return memedImage
    }
    

    @IBAction func shareMeme(sender: AnyObject) {
        let memeImage = self.generateMemedImage()
        let activityItems = [memeImage]
        let activityView = UIActivityViewController.init(activityItems: activityItems, applicationActivities: nil)
        self.presentViewController(activityView, animated: true) { 
            self.save()
            // self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

    @IBAction func cancel(sender: AnyObject) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
        topEditCount = 0
        bottomEditCount = 0
    }

}
