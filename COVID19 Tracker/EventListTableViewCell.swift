//
//  EventListTableViewCell.swift
//  COVID19 Tracker
//
//  Created by kishore saravanan on 12/01/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {
    @IBOutlet weak var recnum: UILabel!
    @IBOutlet weak var decnum: UILabel!
    @IBOutlet weak var contod: UILabel!
    @IBOutlet weak var rectod: UILabel!
    @IBOutlet weak var dectod: UILabel!
    @IBOutlet weak var countlabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
