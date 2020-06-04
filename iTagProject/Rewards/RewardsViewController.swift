//
//  RewardsViewController.swift
//  iTagProject
//
//  Created by Swapna Botta on 30/03/20.
//  Copyright © 2020 iTag. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var rewardTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        rewardTableView.register(UINib (nibName: "RewardsTableViewCell", bundle: nil), forCellReuseIdentifier: "LeavesCell")

        
    }
    @IBAction func backButn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return 10
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:RewardsTableViewCell=rewardTableView.dequeueReusableCell(withIdentifier: "LeavesCell") as! RewardsTableViewCell
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 125
        }
}
