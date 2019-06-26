//
//  CalendarViewController.swift
//  HedgehogApp
//
//  Created by 若原昌史 on 2019/02/15.
//  Copyright © 2019 若原昌史. All rights reserved.
//

import UIKit
import RealmSwift
import FSCalendar
import CSS3ColorsSwift
import CalculateCalendarLogic

@available(iOS 10.0, *)
class CalendarViewController: UIViewController ,FSCalendarDataSource,FSCalendarDelegate{
    
    private let realm = try! Realm()
    @IBOutlet weak var calendar: FSCalendar!
    
    private lazy var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.todayColor = UIColor.mediumAquamarine
        calendar.appearance.selectionColor = UIColor.lightSkyBlue
        self.navigationItem.title = "体調管理"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.lightSkyBlue]
    }
    
    /// 祝日かどうかを判断するメソッド
    ///
    /// - Parameter date: 祝日かどうかを比較する日付
    /// - Returns: 祝日か否かをBool型でreturnする
    private func judgeHoliday(_ date:Date) -> Bool{
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    /// 何曜日かを判定するメソッド
    ///
    /// - Parameter date: 判断する日付
    /// - Returns: 何番目の数字かをInt型でreturnする
    private func getWeekIndex(_ date:Date) -> Int{
        let tmpCalendar:Calendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if self.judgeHoliday(date){
            return UIColor.red
        }
        let weekIndex = getWeekIndex(date)
        if weekIndex == 1{
            return UIColor.red
        }else if weekIndex == 7{
            return UIColor.blue
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthManagementViewController") as! HealthManagementViewController
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        
        vc.todayDate = formatter.string(from: date)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        return [UIColor.orange]
    }

}
