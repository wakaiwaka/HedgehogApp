//
//  WeightTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol InputTextTableCellDelegate:class {
    func weightTextFieldDidEndEditing(value:String)
}

class WeightTableViewCell: UITableViewCell,UITextFieldDelegate{
    
    public weak var delegate:InputTextTableCellDelegate?
    
    @IBOutlet weak var wightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    public var textFieldWord = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.weightTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(text:String){
        self.weightTextField.text = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text{
            self.delegate?.weightTextFieldDidEndEditing(value: text)
        }
    }
    
}
