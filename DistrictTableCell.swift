//
//  DistrictTableCell.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 13/04/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit

class DistrictTableCell: UITableViewCell {
    @IBOutlet weak var DistrictName: UILabel!
    @IBOutlet weak var ConfirmedTotal: UILabel!
    @IBOutlet weak var DeltaConfirmed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
