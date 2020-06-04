//
//  EditAddressTableViewCell.swift
//  iTagProject
//
//  Created by Swapna Botta on 25/05/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class EditAddressTableViewCell: UITableViewCell {
    
    @IBOutlet var nameHeader: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
