//
//  MemeViewController+ImagePickerControllerDelegate.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/3/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: UIImagePickerControllerDelegate Implementation
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      memeImageView.image = image
      shareButton.isEnabled = true
    }
    
    self.dismiss(animated: true, completion: nil)
  }
    
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
}
