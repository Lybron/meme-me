//
//  MemeStore.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/6/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

class MemeStore: NSObject {
  
  static let shared = MemeStore()
  
  var memes = [Meme]()
    
}

extension MemeStore {
  func save(_ meme: Meme) {
    memes.append(meme)
  }
}
