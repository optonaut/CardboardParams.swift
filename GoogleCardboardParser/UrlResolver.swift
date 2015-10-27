//
//  UrlResolver.swift
//  GoogleCardboardParser
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public class URLResolver: NSObject  {
    
    static func resolve(url: String, onCompleted: NSData? -> Void) {
        guard let url = NSURL(string: url) else {
            onCompleted(nil)
            return
        }
    
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: URLResolver(),
            delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url) {(data, response, error) in
            guard let httpResponse = response as? NSHTTPURLResponse else {
                onCompleted(nil)
                return
            }
            
            if httpResponse.statusCode == 301 && httpResponse.allHeaderFields["Location"] != nil {
                let newUrl = httpResponse.allHeaderFields["Location"] as! String
                if let prefixRange = newUrl.rangeOfString("http://google.com/cardboard/cfg?p=") {
                    let suffixStart = newUrl.startIndex.advancedBy(prefixRange.count)
                    let suffix = newUrl.substringFromIndex(suffixStart)
                    onCompleted(NSData(base64EncodedString: suffix, options: []))
                }
            } else {
                onCompleted(nil)
            }
        }
        
        task.resume()
    }
    
}

extension URLResolver: NSURLSessionDelegate {
    
    func URLSession(session: NSURLSession,
                    task: NSURLSessionTask,
                    willPerformHTTPRedirection response: NSHTTPURLResponse,
                    newRequest request: NSURLRequest,
                    completionHandler: (NSURLRequest!) -> Void) {
        completionHandler(nil)
    }
    
}