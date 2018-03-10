//
//  ViewController.swift
//  Custom_Calender
//
//  Created by Raghul SV on 10/25/17.
//  Copyright © 2017 Raghul SV. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var monthlbl: UILabel!
    
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    var numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth = getFirstWeekDay()
        
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
//         myCollectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
//        
        self.myCollectionView.register(UINib(nibName:"DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
    }
        
    @IBAction func prevbtn(_ sender: UIButton) {
        currentMonthIndex -= 1
        if currentMonthIndex < 1 { 
            currentMonthIndex = 12
            currentYear -= 1
            
        }
        
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        myCollectionView.reloadData()
        monthlbl.text="\(monthsArr[currentMonthIndex-1]) \(currentYear)"
        

      
    }
    @IBAction func Nextbtn(_ sender: UIButton) {
        currentMonthIndex += 1
        if currentMonthIndex > 12 {
            currentMonthIndex = 1
            currentYear += 1
            
        }
        
        firstWeekDayOfMonth=getFirstWeekDay()
        
        myCollectionView.reloadData()
        monthlbl.text="\(monthsArr[currentMonthIndex-1]) \(currentYear)"
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInMonth[currentMonthIndex-1] + firstWeekDayOfMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        cell.backgroundColor = UIColor.clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden = true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.datelbl.text = "\(calcDate)"
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=false
                cell.datelbl.textColor = UIColor.lightGray
                
            } else {
                cell.isUserInteractionEnabled=true
                cell.datelbl.textColor=UIColor.black
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.darkGray
//        let lbl = cell?.subviews[1] as! UILabel
//        lbl.textColor=UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
//        let lbl = cell?.subviews[1] as! UILabel
//        lbl.textColor = UIColor.blue
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func getFirstWeekDay() -> Int {
        print("getFirstWeekDay: \(currentYear) \(currentMonthIndex)")
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        return day == 7 ? 1 : day
    }
    

   

}
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

//get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}


