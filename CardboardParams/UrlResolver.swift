//
//  UrlResolver.swift
//  CardboardParams
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation
import Result

    
public enum CardboardError: ErrorType {
    case URLFormatError(String)
    case URLResolveError(String)
    case Base64DecodingError(String)
    case ParserError(String)
}

internal class URLResolver: NSObject  {
    
    typealias URLResolverResult = Result<String, CardboardError>
    
    static func resolve(urlStr: String, onCompleted: URLResolverResult -> Void) {
        guard let url = NSURL(string: urlStr) else {
            onCompleted(URLResolverResult(error: .URLFormatError("Input given is not an URL: \(urlStr)")))
            return
        }
    
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: URLResolver(),
            delegateQueue: nil)
        
        let task = session.dataTaskWithURL(url) {(data, response, error) in
            if let error = error {
                onCompleted(URLResolverResult(error: .URLResolveError("Error resolving URL: \(urlStr), \(error)")))
                return

            }
            guard let httpResponse = response as? NSHTTPURLResponse else {
                onCompleted(URLResolverResult(error: .URLResolveError("Input given is not a HTTP URL: \(urlStr)")))
                return
            }
            
            if httpResponse.statusCode == 301 && httpResponse.allHeaderFields["Location"] != nil {
                let newUrl = httpResponse.allHeaderFields["Location"] as! String
                if let prefixRange = newUrl.rangeOfString("http://google.com/cardboard/cfg?p=") {
                    let suffixStart = newUrl.startIndex.advancedBy(prefixRange.count)
                    let suffixString = newUrl.substringFromIndex(suffixStart)
                    
                    onCompleted(URLResolverResult(value: suffixString))
                }
            } else {
                onCompleted(URLResolverResult(error: .URLResolveError("Given URL did not contain any cardboard data: \(urlStr)")))
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
