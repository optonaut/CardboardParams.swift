//
//  UrlResolver.swift
//  GoogleCardboardParser
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

internal class URLResolver: NSObject  {
    
    static func resolve(url_: String, onCompleted: (NSData?, CardboardParserError?) -> Void) {
        guard let url = NSURL(string: url_) else {
            onCompleted(nil, CardboardParserError.URLFormatError("Input given is not an URL: \(url_)"))
            return
        }
    
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: URLResolver(),
            delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url) {(data, response, error) in
            if let error = error {
                onCompleted(nil, CardboardParserError.URLResolveError("Error resolving URL: \(url_), \(error)"))
                return

            }
            guard let httpResponse = response as? NSHTTPURLResponse else {
                onCompleted(nil, CardboardParserError.URLResolveError("Input given is not a HTTP URL: \(url_)"))
                return
            }
            
            if httpResponse.statusCode == 301 && httpResponse.allHeaderFields["Location"] != nil {
                let newUrl = httpResponse.allHeaderFields["Location"] as! String
                if let prefixRange = newUrl.rangeOfString("http://google.com/cardboard/cfg?p=") {
                    let suffixStart = newUrl.startIndex.advancedBy(prefixRange.count)
                    let suffix = newUrl.substringFromIndex(suffixStart)
                    onCompleted(NSData(base64EncodedString: suffix, options: []), nil)
                }
            } else {
                onCompleted(nil, CardboardParserError.URLResolveError("Given URL did not contain any cardboard data: \(url_)"))
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