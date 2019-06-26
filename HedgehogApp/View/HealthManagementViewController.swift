//
//  HealthManagementViewController.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class HealthManagementViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    public var todayDate:String?
    @IBOutlet weak var tableView: UITableView!
    private var valueDic:[String:Any] = [:]
    
    private let db = Firestore.firestore()
    
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
            cell.delegate = self
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "claw", for: indexPath) as! ClawConditionTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.setCell(clawCondition: false)
            cell.delegate = self
            return cell
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "unchi", for: indexPath) as! UnchiColorTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.setCell(unchiCondition: false)
            cell.delegate = self
            return cell
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "runnyNose", for: indexPath) as! RunnyNoseTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.setCell(runnyNose: false)
            cell.delegate = self
            return cell
        case 4:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "giving", for: indexPath) as! GivingFoodTableViewCell
            cell.layoutIfNeeded()
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 5:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "note", for: indexPath) as! NoteTableViewCell
            cell.selectionStyle = .none
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
        
        guard let weight = self.valueDic["weight"] else {
            return
        }
        guard let givingFood = self.valueDic["givingFood"] else {
            return
        }
        guard let clawCondition = self.valueDic["clowCondition"] else {
            return
        }
        guard let unchiColor = self.valueDic["unchiColor"] else {
            return
        }
        
        guard let runnyNose = self.valueDic["runnyNose"] else{
            return
        }
        
        guard let note = self.valueDic["note"] else {
            return
        }
        
        guard let todayDate = self.todayDate else {
            return
        }
        
        //FIRESTOREにデータを保存する
        db.collection("todos").document(todayDate).setData(["weight" : weight,"givingoFood" : givingFood,"clowCondition" : clawCondition,"unchiColor" : unchiColor, "runnyNose" :  runnyNose, "note" : note], merge: true) { err in
            if err != nil{
                return print("FIRESTORE_UPDATE_TODOS_ERROR")
            }else{
                return print("FIRESTORE_UPDATE_TODOS_SUCCESS")
            }
        }
    }
    
}

extension HealthManagementViewController: InputTextTableCellDelegate,GivingFoodTableViewCellDelegate,ClawConditionTableViewCellDelegate,UnchiColorTableViewCellDelegate,RunnyNoseTableViewCellDelegate,NoteTableViewCellDelegate{
    
    func weightTextFieldDidEndEditing(value: String) {
        self.valueDic.updateValue(value, forKey: "weight")
        print(self.valueDic["weight"]!)
    }
    
    func foodTextFieldDidEndEditing(value: String) {
        self.valueDic.updateValue(value, forKey: "givingFood")
        print(self.valueDic["givingFood"]!)
    }
    
    func clawButtonDidEndTapped(isDone: Bool) {
        self.valueDic.updateValue(isDone, forKey: "clawCondition")
        print(self.valueDic["clawCondition"]!)
    }
    
    func unchiButtonDidEndTapped(isDone: Bool) {
        self.valueDic.updateValue(isDone, forKey: "unchiColor")
        print(self.valueDic["unchiColor"]!)
    }
    
    func noseButtonDidEndTapped(isDone: Bool) {
        self.valueDic.updateValue(isDone, forKey: "runnyNose")
        print(valueDic["runnyNose"]!)
    }
    
    func noteTextFieldDidEndEditing(value: String) {
        self.valueDic.updateValue(value, forKey: "note")
        print(valueDic["note"]!)
    }
}
