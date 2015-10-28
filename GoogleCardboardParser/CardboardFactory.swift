//
//  CardboardFactory.swift
//  GoogleCardboardParser
//
//  Created by Emi on 26/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public enum CardboardParserError : ErrorType {
    case URLFormatError(String)
    case URLResolveError(String)
    case Base64DecodingError(String)
    case ParserError(String)
}

public class CardboardFactory {
    
    public static func CardboardParamsFromUrl(url: String, onCompleted: (CardboardParams?, CardboardParserError?) -> Void) {
        URLResolver.resolve(url, onCompleted: { data, error in
            guard let data = data else {
                onCompleted(nil, error)
                return
            }
            
            do {
                let headset = try CardboardFactory.CardboardParamsFromData(data)
                onCompleted(headset, nil)
            } catch {
                onCompleted(nil, error as? CardboardParserError)
            }
        })
    }
    
    public static func CardboardParamsFromData(data: NSData) throws -> CardboardParams {
        do {
            let headset = try Headset.parseFromData(data)
            let params = CardboardParams(root: headset, data: data)
            return params
        } catch {
            throw CardboardParserError.ParserError("Failed to parse cardboard data using protobuf: \(error)")
        }
    }
    
    public static func CardboardParamsFromBase64(base64: String) throws -> CardboardParams {
        //Replace base64url chars with base64 chars. 
        var safe = base64.stringByReplacingOccurrencesOfString("-", withString: "+",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        safe = safe.stringByReplacingOccurrencesOfString("_", withString: "/",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        while safe.characters.count % 4 != 0 {
            safe = safe + "="
        }
        
        guard let data = NSData(base64EncodedString: safe, options: NSDataBase64DecodingOptions(rawValue: 0)) else {
            throw CardboardParserError.Base64DecodingError("Failed to decode base64 string: \(base64)")
        }
        
        return try CardboardParamsFromData(data)
    }
}