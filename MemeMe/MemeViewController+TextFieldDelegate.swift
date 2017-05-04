//
//  MemeViewController+TextFieldDelegate.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/3/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
    let text = textField.attributedText?.string
    
    if text == Constants.defaultTopText || text == Constants.defaultBottomText {
      textField.attributedText = nil
    }
  }
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
