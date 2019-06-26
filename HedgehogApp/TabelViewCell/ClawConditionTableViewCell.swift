//
//  ClawConditionTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol ClawConditionTableViewCellDelegate:class {
    func clawButtonDidEndTapped(isDone:Bool)
}

class ClawConditionTableViewCell: UITableViewCell {
    
    public weak var delegate:ClawConditionTableViewCellDelegate?
    
    @IBOutlet weak var clawLabel: UILabel!
    @IBOutlet weak var longClawButton: UIButton!
    @IBOutlet weak var notLongClawButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.longClawButton.addTarget(self, action: #selector(goodConditionButtonTapped), for: .touchUpInside)
        self.notLongClawButton.addTarget(self, action: #selector(badConditionButtonTapped), for: .touchUpInside)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setCell(clawCondition:Bool){
        if clawCondition {
            longClawButton.layer.backgroundColor = UIColor.orange.cgColor
            longClawButton.layer.cornerRadius = 20
            longClawButton.tintColor = UIColor.white
            longClawButton.layer.borderColor = UIColor.orange.cgColor
            longClawButton.layer.masksToBounds = true
            
            notLongClawButton.layer.backgroundColor = UIColor.lightGray.cgColor
            notLongClawButton.layer.cornerRadius = 20
            notLongClawButton.tintColor = UIColor.white
            notLongClawButton.layer.borderColor = UIColor.lightGray.cgColor
            notLongClawButton.layer.masksToBounds = true
        }else{
            longClawButton.layer.backgroundColor = UIColor.lightGray.cgColor
            longClawButton.layer.cornerRadius = 20
            longClawButton.tintColor = UIColor.white
            longClawButton.layer.borderColor = UIColor.lightGray.cgColor
            longClawButton.layer.masksToBounds = true
            
            notLongClawButton.layer.backgroundColor = UIColor.green.cgColor
            notLongClawButton.layer.cornerRadius = 20
            notLongClawButton.tintColor = UIColor.white
            notLongClawButton.layer.borderColor = UIColor.green.cgColor
            notLongClawButton.layer.masksToBounds = true
        }
    }
    
    @objc func goodConditionButtonTapped(){
        self.delegate?.clawButtonDidEndTapped(isDone: true)
        setCell(clawCondition: true)
    }
    
    @objc func badConditionButtonTapped(){
        self.delegate?.clawButtonDidEndTapped(isDone: false)
        setCell(clawCondition: false)
    }
    
}
