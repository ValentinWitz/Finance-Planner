//
//  incomeCell.swift
//  Finance Planner
//
//  Created by Valentin Witzeneder on 08.12.17.
//  Copyright © 2017 Valentin Witzeneder. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
