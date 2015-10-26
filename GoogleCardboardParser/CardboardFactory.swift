//
//  CardboardFactory.swift
//  GoogleCardboardParser
//
//  Created by Emi on 26/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public class CardboardFactory {
    
    public static func CardboardParamsFromUrl(url: String, onCompleted: (CardboardParams?) -> Void) {
        UrlResolver.resolve(url, onCompleted: { data in
            onCompleted(CardboardFactory.CardboardParamsFromData(data!))
        })
    }
    
    public static func CardboardParamsFromData(data: NSData) -> CardboardParams {
        let headset = try! Headset.parseFromData(data)
        let params = CardboardParams(root: headset)
        return params
    }
    
    public static func CardboardParamsFromBase64(base64: String) {
        let data = NSData(base64EncodedString: base64, options: NSDataBase64DecodingOptions(rawValue: 0))
        return CardboardParamsFromData(data: data)
    }
}