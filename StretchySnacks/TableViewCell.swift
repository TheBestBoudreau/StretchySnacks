//
//  TableViewCell.swift
//  StretchySnacks
//
//  Created by Tyler Boudreau on 2018-05-24.
//  Copyright © 2018 Tyler Boudreau. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
