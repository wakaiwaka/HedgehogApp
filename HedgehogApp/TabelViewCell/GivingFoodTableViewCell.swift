//
//  GivingFoodTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/16.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol GivingFoodTableViewCellDelegate:class {
    func foodTextFieldDidEndEditing(value:String)
}

class GivingFoodTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    public weak var delegate:GivingFoodTableViewCellDelegate?
    
    @IBOutlet weak var givingFoodLabel: UILabel!
    @IBOutlet weak var givingFoodTextLabel: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        givingFoodTextLabel.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text{
            self.delegate?.foodTextFieldDidEndEditing(value: text)
        }
    }
}
