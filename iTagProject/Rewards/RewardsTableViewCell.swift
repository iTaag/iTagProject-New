//
//  RewardsTableViewCell.swift
//  LMS
//
//  Created by admin on 12/7/17.
//  Copyright © 2017 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class RewardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        buttonBgView.layer.cornerRadius=2.0
//        buttonBgView.layer.masksToBounds=true
//        buttonBgView.layer.borderColor=UIColor.lightGray.cgColor
//        buttonBgView.layer.borderWidth=1
        
//        arrowIconLabel.font=UIFont(name: "fontawesome", size:15)
//        arrowIconLabel.text=" \u{f0d7}"
//        arrowIconLabel.textColor=UIColor.lightGray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
