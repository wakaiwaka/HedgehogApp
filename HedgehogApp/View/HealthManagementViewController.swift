//
//  HealthManagementViewController.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit
import Firebase

class HealthManagementViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    private let firestore = CloudFirestore()
    public var dailyHealth:DailyHealth!
    public var userId:String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        //カスタムtableViewCellを登録する
        let weightViewNib:UINib = UINib(nibName: "WeightTableViewCell", bundle: nil)
        self.tableView.register(weightViewNib, forCellReuseIdentifier: "weight")
        
        let clawViewNib:UINib = UINib(nibName: "ClawConditionTableViewCell", bundle: nil)
        self.tableView.register(clawViewNib, forCellReuseIdentifier: "claw")
        
        let unchiViewNib:UINib = UINib(nibName: "UnchiColorTableViewCell", bundle: nil)
        self.tableView.register(unchiViewNib, forCellReuseIdentifier: "unchi")
        
        let givingFoodViewNib:UINib = UINib(nibName: "GivingFoodTableViewCell", bundle: nil)
        self.tableView.register(givingFoodViewNib, forCellReuseIdentifier: "giving")
        
        let runnyNoseViewNib:UINib = UINib(nibName: "RunnyNoseTableViewCell", bundle: nil)
        self.tableView.register(runnyNoseViewNib, forCellReuseIdentifier: "runnyNose")
        
        let noteViewNib:UINib = UINib(nibName: "NoteTableViewCell", bundle: nil)
        self.tableView.register(noteViewNib, forCellReuseIdentifier: "note")
        
        
        //cellの高さを動的に変更する
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "weight", for: indexPath) as! WeightTableViewCell
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.weightTextField.text = self.dailyHealth?.weight
            cell.delegate = self
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "claw", for: indexPath) as! ClawConditionTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.setCell(clawCondition: self.dailyHealth!.clawCondition)
            cell.delegate = self
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "unchi", for: indexPath) as! UnchiColorTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.delegate = self
            cell.setCell(unchiCondition: self.dailyHealth!.unchiColor)
            return cell
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "runnyNose", for: indexPath) as! RunnyNoseTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.setCell(runnyNose: self.dailyHealth!.runnyNose)
            cell.delegate = self
            return cell
        case 4:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "giving", for: indexPath) as! GivingFoodTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.givingFoodTextLabel.text = self.dailyHealth?.givingFoodAmount
            cell.delegate = self
            return cell
        case 5:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath) as! NoteTableViewCell
            cell.selectionStyle = .none
            cell.noteTextField.text = self.dailyHealth?.note
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    @IBAction func saveHealthData(_ sender: UIBarButtonItem) {
        self.firestore.createHealth(id: userId, dailyHealth: self.dailyHealth)
    }
}

extension HealthManagementViewController: InputTextTableCellDelegate,GivingFoodTableViewCellDelegate,ClawConditionTableViewCellDelegate,UnchiColorTableViewCellDelegate,RunnyNoseTableViewCellDelegate,NoteTableViewCellDelegate{
    
    func weightTextFieldDidEndEditing(value: String) {
        self.dailyHealth?.weight = value
        print(self.dailyHealth!.weight)
    }
    
    func foodTextFieldDidEndEditing(value: String) {
        self.dailyHealth?.givingFoodAmount = value
        print(self.dailyHealth!.givingFoodAmount)
    }
    
    func clawButtonDidEndTapped(isDone: Bool) {
        self.dailyHealth?.clawCondition = isDone
        print(self.dailyHealth!.clawCondition)
    }
    
    func unchiButtonDidEndTapped(isDone: Bool) {
        self.dailyHealth?.unchiColor = isDone
        print(self.dailyHealth!.unchiColor)
    }
    
    func noseButtonDidEndTapped(isDone: Bool) {
        self.dailyHealth?.runnyNose = isDone
        print(self.dailyHealth!.runnyNose)
    }
    
    func noteTextFieldDidEndEditing(value: String) {
        self.dailyHealth?.note = value
        print(self.dailyHealth?.note)
    }
}
