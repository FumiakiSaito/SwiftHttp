//
//  Augury.swift
//  SwiftHttp
//
//  Created by Fumiaki Saito on 2015/04/02.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import Foundation

class Augury: APIClient {

    // 占いAPIベースURL
    let baseurl = "http://api.jugemkey.jp/api/horoscope/free/"


    // 日付を取得して、占い取得
    func get(forYear year: String, withMonth month: String, withDay day: String) {
 
        let url = self.baseurl + year + "/" + month + "/" + day
        self.httpGet(url, headers: nil, completionHandler: self.process)
        
    }


    // 取得後のコールバック関数
    func process(res: NSURLResponse?, data: NSData?, error: NSError?) -> Void {
        
        if let connection_error = error {
            println("通信エラー")
        }

        if let jsondata = data {
            
            // 結果jsonをパース
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                println("Json Parse Error: \(err!.localizedDescription)")
            }

            println(json)

        }
        
        if let response = res {
            
            let response = response as NSHTTPURLResponse
            if response.statusCode != 200 {
                println("HTTP Error: \(response.statusCode)")
            } else {
                println("HTTP statusCode: \(response.statusCode)")
            }
            
        }
    }
}