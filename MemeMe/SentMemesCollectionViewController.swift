//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/6/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"
private let detailSegueidentifier = "CollectionDetailSegue"

class SentMemesCollectionViewController: UICollectionViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: Properties
  
  let memeStore = MemeStore.shared
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionFlowlayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    collectionView!.reloadData()
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memeStore.memes.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
    
    let meme = memeStore.memes[indexPath.row]
    cell.memeImageView?.image = meme.memedImage
    cell.memeImageView?.contentMode = .scaleToFill
        
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: detailSegueidentifier, sender: memeStore.memes[indexPath.row])
    
    collectionView.deselectItem(at: indexPath, animated: true)
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == detailSegueidentifier {
      if let memeDetailController = segue.destination as? MemeDetailViewController {
        if let meme = sender as? Meme {
          memeDetailController.meme = meme
        }
      }
    }
  }
  
  private func configureCollectionFlowlayout() {
    let space: CGFloat = 3.0
    let dimension = (collectionView!.frame.size.width - (2 * space)) / 3.0
    
    let layout = UICollectionViewFlowLayout()
    
    layout.minimumInteritemSpacing = space
    layout.minimumLineSpacing = space
    layout.itemSize = CGSize(width: dimension, height: dimension)
    
    collectionView!.collectionViewLayout = layout
  }
}
