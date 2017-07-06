//
//  CampaignIndexTableViewCell.swift
//  MG
//
//  Created by Parker Murphy on 7/5/17.
//  Copyright © 2017 Tyler Bank. All rights reserved.
//

import UIKit

class CampaignIndexTableViewCell: UITableViewCell {
    @IBOutlet weak var campaignName: UILabel!
    @IBOutlet weak var gameMasterName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
