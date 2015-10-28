//
//  CardboardParams.swift
//  CardboardParams
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation
import Result

public struct CardboardParams {
    
    public typealias CardboardResult = Result<CardboardParams, CardboardError>

    public enum VerticalAlignment: Int32 {
        case Bottom = 0
        case Center = 1
        case Top = 2
    }
    
    public let vendor: String
    public let model: String
    public let interLensDistance: Float
    public let verticalAlignment: VerticalAlignment
    public let verticalDistanceToLensCenter: Float
    public let screenToLensDistance: Float
    public let leftEyeMaxFov: FieldOfView
    public let hasMagnet: Bool
    public let distortionCoefficients: [Float]
    public let compressedRepresentation: NSData
    
    internal init(root: Headset, data: NSData) {
        vendor = root.vendor
        model = root.model
        interLensDistance = root.interLensDistance
        verticalAlignment = VerticalAlignment(rawValue: root.verticalAlignment)!
        verticalDistanceToLensCenter = root.trayToLensDistance
        hasMagnet = root.hasMagnet
        distortionCoefficients = root.distortionCoefficients
        screenToLensDistance = root.screenToLensDistance
        leftEyeMaxFov = FieldOfView(angles: root.leftEyeFieldOfViewAngles)
        compressedRepresentation = data
    }
    
    public init() {
        vendor = "Google, Inc.";
        model = "Cardboard v1";
        interLensDistance = 0.06
        verticalAlignment = .Bottom
        verticalDistanceToLensCenter = 0.035
        screenToLensDistance = 0.042
        hasMagnet = true
        distortionCoefficients = [0.441, 0.156]
        leftEyeMaxFov = FieldOfView(angles: [40, 40, 40, 40])
        compressedRepresentation = NSData()
    }
    
    public func getYEyeOffsetMeters(screen: ScreenParams) -> Float {
        switch verticalAlignment {
            case .Center:
                return screen.widthMeters / Float(2);
            case .Bottom:
                return verticalDistanceToLensCenter - screen.borderSizeMeters;
            case .Top:
                return screen.widthMeters - (verticalDistanceToLensCenter - screen.borderSizeMeters);
        }
    }
    
    public static func fromUrl(url: String, onCompleted: CardboardResult -> Void) {
        URLResolver.resolve(url, onCompleted: { result in
            switch result {
            case .Success(let string): onCompleted(fromBase64(string))
            case .Failure(let error): onCompleted(.Failure(error))
            }
        })
    }
    
    public static func fromData(data: NSData) -> CardboardResult {
        do {
            let headset = try Headset.parseFromData(data)
            let params = CardboardParams(root: headset, data: data)
            return CardboardResult(value: params)
        } catch {
            return CardboardResult(error: .ParserError("Failed to parse cardboard data using protobuf: \(error)"))
        }
    }
    
    public static func fromBase64(base64: String) -> CardboardResult {
        // Replace base64url chars with base64 chars.
        var safe = base64.stringByReplacingOccurrencesOfString("-", withString: "+",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        safe = safe.stringByReplacingOccurrencesOfString("_", withString: "/",
            options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        while safe.characters.count % 4 != 0 {
            safe = safe + "="
        }
        
        guard let data = NSData(base64EncodedString: safe, options: NSDataBase64DecodingOptions(rawValue: 0)) else {
            return CardboardResult(error: .Base64DecodingError("Failed to decode base64 string: \(base64)"))
        }
        
        return fromData(data)
    }
}
