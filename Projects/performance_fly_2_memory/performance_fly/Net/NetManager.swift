//
//  NetManager.swift
//  performance_fly
//
//  Created by dengjiangzhou on 2018/11/22.
//  Copyright © 2018 dengjiangzhou. All rights reserved.
//

import Foundation


class NetManager: NSObject{
    static let shared = NetManager()
    
    
    // 模拟发日志
    func sendLogs() {
        let headers = [
            "cookie": "foo=bar; bar=baz",
            "accept": "application/json",
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        var postData = "foo=bar".data(using: String.Encoding.utf8)!
        postData.append("&bar=baz".data(using: String.Encoding.utf8)!)
        
        var request = URLRequest(
            url: URL(string: "https://mockbin.org/bin/d7fc711e-dc00-4a53-93e2-870a35163685?foo=bar&foo=baz")!,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: .main)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let response = response {
                print(response)
            }
        }
        dataTask.resume()
    }
}



extension NetManager: URLSessionDelegate {
    
}
