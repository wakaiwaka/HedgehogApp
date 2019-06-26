//
//   DailHealth.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/20.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import Foundation
import RealmSwift

class DailyHealth:Object {
    @objc dynamic var id = 0
    @objc dynamic var weight:Int = 0
    @objc dynamic var clawCondition:Bool = true
    @objc dynamic var unchiColor:Bool = true
    @objc dynamic var givingFoodAmount:Int = 0
    @objc dynamic var runnyNose:Bool = true
    @objc dynamic var condition:String = ""
    @objc dynamic var note:String = ""
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
}
