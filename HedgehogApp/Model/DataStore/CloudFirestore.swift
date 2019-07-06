//
//  CloudFirestore.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/06/27.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import Firebase
import FirebaseFirestore
import CodableFirebase
import SVProgressHUD

class CloudFirestore{
    
    var defaultFirestore = Firestore.firestore()
    
    func createHealth(id:Int?,dailyHealth:DailyHealth?){
        guard let id = id ,let day = dailyHealth?.day else {
            return assertionFailure("idが入ってないけん落とすわ")
        }
        
        let idString = String(id)
        
        let docData = try! FirestoreEncoder().encode(dailyHealth)
        
        defaultFirestore.collection(idString).document(day).setData(docData, merge: true) { (error) in
            SVProgressHUD.show()
            if error != nil{
                SVProgressHUD.showError(withStatus: "エラーが発生しました")
                return print("error:FirebaseCreate")
            }
                    print("uunnko")
            SVProgressHUD.showSuccess(withStatus: "体調を記録しました")
        }
    }
    
    func getDailyHealth(id:Int?,date:Date?) -> DailyHealth?{
        
        guard let id = id ,let date = date else {
            assertionFailure("idが入ってないけん落とすわ")
            return nil
        }
        
        let idString = String(id)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        let dayString = formatter.string(from: date)
        
        var dailyHealth:DailyHealth?
        
        defaultFirestore.collection(idString).document(dayString).getDocument { (document, error) in
            if let document = document {
                dailyHealth = try! FirestoreDecoder().decode(DailyHealth.self, from: document.data()!)
            } else {
                print("Document does not exist")
            }
        }
        return dailyHealth
    }
}
