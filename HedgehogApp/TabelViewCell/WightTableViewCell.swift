//
//  WightTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

class WightTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
