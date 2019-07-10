//
//  NoteTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/05/06.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol NoteTableViewCellDelegate :class {
    func noteTextFieldDidEndEditing(value:String)
}

class NoteTableViewCell: UITableViewCell ,UITextFieldDelegate{
    
    public weak var delegate:NoteTableViewCellDelegate?
    
    @IBOutlet weak var noteTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.noteTextField.delegate = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(text:String){
        self.noteTextField.text = text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text{
            self.delegate?.noteTextFieldDidEndEditing(value: text)
        }
    }
    
}
