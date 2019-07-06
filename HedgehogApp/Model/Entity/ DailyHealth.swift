//
//   DailHealth.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/20.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import Foundation

struct DailyHealth:Codable {
    var day:String
    var weight:String
    var clawCondition:Bool
    var unchiColor:Bool
    var givingFoodAmount:String
    var runnyNose:Bool
    var note:String
    
    init(day:String,weight:String,clawCondition:Bool,unchiColor:Bool,givingFoodAmount:String,runnyNose:Bool,note:String) {
        self.day = day
        self.weight = weight
        self.clawCondition = clawCondition
        self.unchiColor = unchiColor
        self.givingFoodAmount = givingFoodAmount
        self.runnyNose = runnyNose
        self.note = note
    }
}
