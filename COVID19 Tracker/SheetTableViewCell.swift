//
//  SheetTableViewCell.swift
//  Amrita Events
//
//  Created by kishore saravanan on 13/02/20.
//  Copyright © 2020 kishore saravanan. All rights reserved.
//

import UIKit

class SheetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TitleCell: UILabel!
    @IBOutlet weak var LocationCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
