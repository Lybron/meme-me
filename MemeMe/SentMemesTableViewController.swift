//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/6/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

private let tableViewCellidentifier = "TableCell"
private let detailSegueIdentifier = "TableDetailSegue"

class SentMemesTableViewController: UITableViewController {
  
  // MARK: Properties
  
  let memeStore = MemeStore.shared
  
  // MARK: View Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Table view data source & delegate
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memeStore.memes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellidentifier, for: indexPath) as! MemeTableViewCell
    
    let meme = memeStore.memes[indexPath.row]
    
    cell.titleTextLabel?.text = meme.topText + "..." + meme.bottomText
    
    cell.memeImageView?.image = meme.memedImage
    cell.memeImageView?.contentMode = .scaleToFill
    
    return cell
  }
    
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      memeStore.memes.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: detailSegueIdentifier, sender: memeStore.memes[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == detailSegueIdentifier {
      if let memeDetailController = segue.destination as? MemeDetailViewController {
        if let meme = sender as? Meme {
          memeDetailController.meme = meme
        }
      }
    }
  }
  
  @IBAction func unwindToSentMemes(segue: UIStoryboardSegue) {}
  
}
