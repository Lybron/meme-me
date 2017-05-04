//
//  FontsTableViewController.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/4/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

class FontsTableViewController: UITableViewController {
  
  let fontNames = UIFont.familyNames.sorted(by: { $0 < $1 })
  
  override func viewDidLoad() {
    super.viewDidLoad()    
  }
  
  // MARK: - Table view data source & delegate
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fontNames.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FontNameCell", for: indexPath)
    
    cell.textLabel?.text = fontNames[indexPath.row]
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if let navigationController = navigationController {
      if let memeVC = navigationController.childViewControllers[0] as? MemeViewController {
        
        let selectedFont = fontNames[indexPath.row]
        memeVC.setTextFont(name: selectedFont)
        
        navigationController.popToViewController(memeVC, animated: true)
      }
    }
    
  }
 
}
