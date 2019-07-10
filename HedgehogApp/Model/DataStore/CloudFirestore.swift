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
    
    func createHealth(id:String?,dailyHealth:DailyHealth?){
        guard let id = id ,let day = dailyHealth?.day else {
            return assertionFailure("idが入ってないけん落とすわ")
        }
        
        let docData = try! FirestoreEncoder().encode(dailyHealth)
        
        defaultFirestore.collection(id).document(day).setData(docData, merge: true) { (error) in
            SVProgressHUD.show()
            if error != nil{
                SVProgressHUD.showError(withStatus: "エラーが発生しました")
                return print("error:FirebaseCreate")
            }
                    print("uunnko")
            SVProgressHUD.showSuccess(withStatus: "体調を記録しました")
        }
    }
    
    func getDailyHealth(id:String?,date:String?) -> DailyHealth!{
        
        guard let id = id ,let date = date else {
            assertionFailure("idが入ってないけん落とすわ")
            return nil
        }
        
        var dailyHealth:DailyHealth!
        
        defaultFirestore.collection(id).document(date).getDocument { (document, error) in
            if error != nil{
                return
            }
            if let document = document?.data() {
                dailyHealth = try! FirestoreDecoder().decode(DailyHealth.self, from: document)
            } else {
                print("Document does not exist")
            }
        }
        return dailyHealth
    }
}
