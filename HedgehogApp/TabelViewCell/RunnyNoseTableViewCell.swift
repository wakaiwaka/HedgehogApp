
//
//  RunnyNoseTableViewCell.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/16.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit

protocol RunnyNoseTableViewCellDelegate :class {
    func noseButtonDidEndTapped(isDone:Bool)
}

class RunnyNoseTableViewCell: UITableViewCell {
    
    public weak var delegate:RunnyNoseTableViewCellDelegate?
    
    @IBOutlet weak var runnyNoseLabel: UILabel!
    @IBOutlet weak var runnyNoseButton: UIButton!
    @IBOutlet weak var NotRunnyNoseButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        runnyNoseButton.addTarget(self, action: #selector(goodConditionButtonTapped), for: .touchUpInside)
        NotRunnyNoseButton.addTarget(self, action: #selector(badConditionButtonTapped), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCell(runnyNose:Bool){
        if runnyNose {
            runnyNoseButton.layer.backgroundColor = UIColor.orange.cgColor
            runnyNoseButton.layer.cornerRadius = 20
            runnyNoseButton.tintColor = UIColor.white
            runnyNoseButton.layer.borderColor = UIColor.orange.cgColor
            runnyNoseButton.layer.masksToBounds = true
            
            NotRunnyNoseButton.layer.backgroundColor = UIColor.gray.cgColor
            NotRunnyNoseButton.layer.cornerRadius = 20
            NotRunnyNoseButton.tintColor = UIColor.white
            NotRunnyNoseButton.layer.borderColor = UIColor.gray.cgColor
            NotRunnyNoseButton.layer.masksToBounds = true
        }else{
            runnyNoseButton.layer.backgroundColor = UIColor.gray.cgColor
            runnyNoseButton.layer.cornerRadius = 20
            runnyNoseButton.tintColor = UIColor.white
            runnyNoseButton.layer.borderColor = UIColor.gray.cgColor
            runnyNoseButton.layer.masksToBounds = true
            
            NotRunnyNoseButton.layer.backgroundColor = UIColor.green.cgColor
            NotRunnyNoseButton.layer.cornerRadius = 20
            NotRunnyNoseButton.tintColor = UIColor.white
            NotRunnyNoseButton.layer.borderColor = UIColor.green.cgColor
            NotRunnyNoseButton.layer.masksToBounds = true
        }
    }
    
    @objc func goodConditionButtonTapped(){
        self.delegate?.noseButtonDidEndTapped(isDone: true)
        setCell(runnyNose: true)
    }
    
    @objc func badConditionButtonTapped(){
        self.delegate?.noseButtonDidEndTapped(isDone: false)
        setCell(runnyNose: false)
    }
    
}
