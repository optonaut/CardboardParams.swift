//
//  UrlResolver.swift
//  CardboardParams
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation
import Result

    
public enum CardboardError: Error {
    case urlFormatError(String)
    case urlResolveError(String)
    case base64DecodingError(String)
    case parserError(String)
}

internal class URLResolver: NSObject  {
    
    typealias URLResolverResult = Result<String, CardboardError>
    
    static func resolve(_ urlStr: String, onCompleted: @escaping (URLResolverResult) -> Void) {
        guard let url = URL(string: urlStr) else {
            onCompleted(URLResolverResult(error: .urlFormatError("Input given is not an URL: \(urlStr)")))
            return
        }
    
        let session = Foundation.URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: URLResolver(),
            delegateQueue: nil)
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            if let error = error {
                onCompleted(URLResolverResult(error: .urlResolveError("Error resolving URL: \(urlStr), \(error)")))
                return

            }
            guard let httpResponse = response as? HTTPURLResponse else {
                onCompleted(URLResolverResult(error: .urlResolveError("Input given is not a HTTP URL: \(urlStr)")))
                return
            }
            
            if httpResponse.statusCode == 301 && httpResponse.allHeaderFields["Location"] != nil {
                let newUrl = httpResponse.allHeaderFields["Location"] as! String
                if let prefixRange = newUrl.range(of: "http://google.com/cardboard/cfg?p=") {
                    let suffixStart = prefixRange.upperBound
                    let suffixString = newUrl.substring(from: suffixStart)
                    
                    onCompleted(URLResolverResult(value: suffixString))
                }
            } else {
                onCompleted(URLResolverResult(error: .urlResolveError("Given URL did not contain any cardboard data: \(urlStr)")))
            }
        }) 
        
        task.resume()
    }
    
}

extension URLResolver: URLSessionDelegate {
    
    func URLSession(_ session: Foundation.URLSession,
                    task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: (URLRequest!) -> Void) {
        completionHandler(nil)
    }
    
}
