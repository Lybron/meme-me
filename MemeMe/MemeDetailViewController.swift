//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/7/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
  
  @IBOutlet weak var memeImageView: UIImageView!
  
  var meme: Meme?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    memeImageView.image = meme?.memedImage
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    tabBarController?.tabBar.isHidden = false
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "MemeEditSegue"  {
      if let meme = self.meme {
        if let destinationNavController = segue.destination as? UINavigationController {
          if let memeVC = destinationNavController.childViewControllers[0] as? MemeViewController {
            memeVC.meme = meme
          }
        }
      }
    }
  }
  
}
