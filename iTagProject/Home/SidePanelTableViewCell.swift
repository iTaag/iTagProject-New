//
//  SidePanelTableViewCell.swift
//  LMS
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class SidePanelTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
