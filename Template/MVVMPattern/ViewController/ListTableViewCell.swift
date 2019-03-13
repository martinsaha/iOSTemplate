//
//  ListTableViewCell.swift
//  Template
//
//  Created by Martin Prabhu on 13/03/19.
//  Copyright © 2019 TAG. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblResp1: UILabel!
    @IBOutlet weak var lblResp4: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

