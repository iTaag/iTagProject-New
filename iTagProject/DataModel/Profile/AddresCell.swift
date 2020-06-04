//
//  AddresCell.swift
//  iTag
//
//  Created by pullayya Bandaru on 30/10/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class AddresCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
