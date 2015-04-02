//
//  APIClient.swift
//  SwiftHttp
//
//  Created by Fumiaki Saito on 2015/04/02.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import Foundation

public class APIClient {
    
    var isInLoad = false
    
    // GETリクエスト
    public func httpGet(url: String, headers: [String: String]?, completionHandler: ((NSURLResponse?, NSData?, NSError?) -> Void)!)
    {
        self.isInLoad = true
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"

        // ヘッダ追加
        if let header = headers {
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if(error != nil) {
                completionHandler(nil, nil, error)
                return
            }
            
            let response = response as NSHTTPURLResponse
            if response.statusCode >= 200 &&  response.statusCode <= 299 {
                completionHandler(response, data, nil)
            } else {
                completionHandler(response, nil, nil)
            }
            
            self.isInLoad = false
        })
        
        task.resume()
        
        while isInLoad {
            usleep(10)
        }
    }
    
    
    // POSTリクエスト
    public func httpPost(url: String, headers: [String: String], params: [String: AnyObject], completionHandler: ((NSURLResponse?, NSData?, NSError?) -> Void)!)
    {
        self.isInLoad = true
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        
        // ヘッダ設定
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        
        // パラメータ設定
        var body = ""
        for (key, value) in params {
            // URLエンコード
            let encodeValue = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
            let encodeKey   = key.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
            if body.isEmpty {
                body = "\(encodeKey)=\(encodeValue)"
            } else {
                body += "&\(encodeKey)=\(encodeValue)"
            }
        }
        
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding);
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if(error == nil) {
                let response = response as NSHTTPURLResponse
                if response.statusCode >= 200 &&  response.statusCode <= 299 {
                    completionHandler(response, data, nil)
                } else {
                    completionHandler(response, nil, nil)
                }
            } else {
                completionHandler(nil, nil, error)
            }
            
            self.isInLoad = false
        })
        
        task.resume()
        
        while isInLoad {
            usleep(10)
        }
    }
}