//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/3/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import Foundation
import UIKit

class MemeViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var topTextField: UITextField!
  @IBOutlet weak var bottomTextField: UITextField!
  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var shareButton: UIBarButtonItem!
  @IBOutlet weak var bottomBar: UIToolbar!
  
  // MAKRK: Properties
  
  let memeStore = MemeStore.shared
  var meme: Meme?
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureInitialUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  // MARK: Notification Subscription
  
  func subscribeToKeyboardNotifications() {
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  // MARK: Notification Handlers
  
  func keyboardWillShow(_ notification:Notification) {
    
    if bottomTextField.isFirstResponder {
      view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
  }
  
  func keyboardWillHide(_ notification: Notification) {
    view.frame.origin.y = 0
  }
  
  func getKeyboardHeight(_ notification: Notification) -> CGFloat {
    
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height
  }
  
  // MARK: IBActions
  
  @IBAction func cancelButtonPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func pickPhoto(_ sender: UIBarButtonItem) {
    let imagePickerController = UIImagePickerController()
    
    switch sender.tag {
      
    case 1:
      imagePickerController.sourceType = .photoLibrary
    case 2:
      imagePickerController.sourceType = .camera
      imagePickerController.showsCameraControls = true
    default:
      imagePickerController.sourceType = .photoLibrary
      
    }
    
    imagePickerController.delegate = self
    imagePickerController.allowsEditing = false
    
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @IBAction func shareMeme() {
    let memedImage = generateMemedImage()
    let shareController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
    
    shareController.completionWithItemsHandler = { Void in
      let meme = Meme(topText: self.topTextField.text!,
                      bottomText: self.bottomTextField.text!,
                      fontName: self.topTextField.font!.familyName,
                      originalImage: self.memeImageView.image!,
                      memedImage: memedImage)
      
      self.memeStore.save(meme)
      self.performSegue(withIdentifier: "UnwindToSentMemesSegue", sender: self)
    }
    
    self.present(shareController, animated: true, completion: nil)
    
  }
  
  @IBAction func toggleImageContentMode(_ sender: Any) {
    
    switch memeImageView.contentMode {
    case .scaleAspectFit:
      memeImageView.contentMode = .scaleAspectFill
    case .scaleAspectFill:
      memeImageView.contentMode = .scaleAspectFit
    default:
      memeImageView.contentMode = .scaleAspectFit
    }
    
  }
    
  // MARK: Generate Memes
  private func generateMemedImage() -> UIImage {
    
    hideBars(true)
    
    UIGraphicsBeginImageContext(self.memeImageView.frame.size)
    view.drawHierarchy(in: self.memeImageView.frame, afterScreenUpdates: true)
    let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
        
    hideBars(false)
    
    return memedImage
  }
  
  private func hideBars(_ hidden: Bool) {
    navigationController?.isNavigationBarHidden = hidden
    bottomBar.isHidden = hidden
  }
  
  // MARK: Prepare UI
  private func configureInitialUI() {
    
    configureMemeView()
    
    topTextField.delegate = self
    bottomTextField.delegate = self
    
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
  }
  
  private func configureMemeView() {
    if let meme = self.meme {
      topTextField.attributedText = NSAttributedString(string: meme.topText)
      bottomTextField.attributedText = NSAttributedString(string: meme.bottomText)
      setTextFont(name: meme.fontName)
      memeImageView.image = meme.originalImage
    } else {
      setDefaultText()
      shareButton.isEnabled = false
    }
  }
  
  private func setDefaultText() {
    setTextFont(name: "Impact")
    topTextField.attributedText = NSAttributedString(string: Constants.defaultTopText)
    bottomTextField.attributedText = NSAttributedString(string: Constants.defaultBottomText)
    
  }
  
  public func setTextFont(name: String) {
    
    self.view.endEditing(true)

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    
    let memeTextAttributes: [String: Any] = [
      NSFontAttributeName: UIFont(name: name, size: 40)!,
      NSStrokeColorAttributeName: UIColor.black,
      NSForegroundColorAttributeName: UIColor.white,
      NSStrokeWidthAttributeName: NSNumber(value: -3.0),
      NSParagraphStyleAttributeName: paragraphStyle]
    
    topTextField.defaultTextAttributes = memeTextAttributes
    bottomTextField.defaultTextAttributes = memeTextAttributes
    
  }
}
