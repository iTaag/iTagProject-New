//
//  ChatDashboardTableViewCell.swift
//  LMS
//
//  Created by kranthi on 18/07/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class ChatDashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personImageContainer: GRView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
