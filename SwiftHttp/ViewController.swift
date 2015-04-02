//
//  ViewController.swift
//  SwiftHttp
//
//  Created by Fumiaki Saito on 2015/04/02.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 今日の日付取得
        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")

        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.stringFromDate(now)

        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.stringFromDate(now)

        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.stringFromDate(now)

        // 占いAPIで今日の占いを取得
        let augury = Augury()
        augury.get(forYear: year, withMonth: month, withDay: day)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

