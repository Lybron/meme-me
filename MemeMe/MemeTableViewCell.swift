//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Lybron Sobers on 3/7/17.
//  Copyright © 2017 Lybron Sobers. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

  @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var titleTextLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
