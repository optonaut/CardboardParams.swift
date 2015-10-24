//
//  UrlResolver.swift
//  GoogleCardboardParser
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public class UrlResolver : NSObject, NSURLSessionDelegate {
    
    static func resolve(url: String, onCompleted: (NSData?) -> Void) {
        let url = NSURL(string: url)
    
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: UrlResolver(),
            delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url!) {(data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            
            if httpResponse.statusCode == 301 && httpResponse.allHeaderFields["Location"] != nil {
                let newUrl = httpResponse.allHeaderFields["Location"] as! String
                if let prefixRange = newUrl.rangeOfString("http://google.com/cardboard/cfg?p=") {
                    let suffixStart = newUrl.startIndex.advancedBy(prefixRange.count)
                    let suffix = newUrl.substringFromIndex(suffixStart)
                    onCompleted(NSData(base64EncodedString: suffix, options: NSDataBase64DecodingOptions(rawValue: 0)))
                }
            } else {
                onCompleted(nil)
            }
        }
        
        task.resume()
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask,
        willPerformHTTPRedirection response: NSHTTPURLResponse,
        newRequest request: NSURLRequest, completionHandler: (NSURLRequest!) -> Void) {
        completionHandler(nil)
    }
}