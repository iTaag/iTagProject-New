//
//  ReceiverChatTableViewCell.swift
//  Dr.Medivault
//
//  Created by ICREA on 28/02/19.
//  Copyright © 2019 ICREA INFOTECH PVT LTD. All rights reserved.
//

import UIKit

class ReceiverChatTableViewCell: UITableViewCell {

   
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var receiverTextLbl: UILabel!
    @IBOutlet weak var cancelButton: GRButton!
    @IBOutlet weak var connectButton: GRButton!
    @IBOutlet weak var nameLabel1: UILabel!
    @IBOutlet weak var connectButton1: GRButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var bgView1: UIView!
    
    @IBOutlet weak var passwordLbl: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
