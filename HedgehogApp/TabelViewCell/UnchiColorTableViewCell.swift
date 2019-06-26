//
//  UnchiColorTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/16.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol UnchiColorTableViewCellDelegate :class{
    func unchiButtonDidEndTapped(isDone:Bool)
}

class UnchiColorTableViewCell: UITableViewCell {
    
    public weak var delegate:UnchiColorTableViewCellDelegate?
    
    @IBOutlet weak var unchiColorLabel: UILabel!
    @IBOutlet weak var fineUnchiButton: UIButton!
    @IBOutlet weak var notFineUnchiButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fineUnchiButton.addTarget(self, action: #selector(goodConditionButtonTapped), for: .touchUpInside)
        self.notFineUnchiButton.addTarget(self, action: #selector(badConditionButtonTapped), for: .touchUpInside)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func setCell(unchiCondition:Bool){
        if unchiCondition {
            fineUnchiButton.layer.backgroundColor = UIColor.orange.cgColor
            fineUnchiButton.layer.cornerRadius = 20
            fineUnchiButton.tintColor = UIColor.white
            fineUnchiButton.layer.borderColor = UIColor.orange.cgColor
            fineUnchiButton.layer.masksToBounds = true
            
            notFineUnchiButton.layer.backgroundColor = UIColor.gray.cgColor
            notFineUnchiButton.layer.cornerRadius = 20
            notFineUnchiButton.tintColor = UIColor.white
            notFineUnchiButton.layer.borderColor = UIColor.gray.cgColor
            notFineUnchiButton.layer.masksToBounds = true
        }else{
            fineUnchiButton.layer.backgroundColor = UIColor.gray.cgColor
            fineUnchiButton.layer.cornerRadius = 20
            fineUnchiButton.tintColor = UIColor.white
            fineUnchiButton.layer.borderColor = UIColor.gray.cgColor
            fineUnchiButton.layer.masksToBounds = true
            
            notFineUnchiButton.layer.backgroundColor = UIColor.green.cgColor
            notFineUnchiButton.layer.cornerRadius = 20
            notFineUnchiButton.tintColor = UIColor.white
            notFineUnchiButton.layer.borderColor = UIColor.green.cgColor
            notFineUnchiButton.layer.masksToBounds = true
        }
    }
    
    @objc func goodConditionButtonTapped(){
        self.delegate?.unchiButtonDidEndTapped(isDone: true)
        setCell(unchiCondition: true)
    }
    
    @objc func badConditionButtonTapped(){
        self.delegate?.unchiButtonDidEndTapped(isDone: false)
        setCell(unchiCondition: false)
    }
    
}
