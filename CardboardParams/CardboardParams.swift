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
        case bottom = 0
        case center = 1
        case top = 2
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
    public let compressedRepresentation: Data
    
    internal init(root: Headset, data: Data) {
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
        verticalAlignment = .bottom
        verticalDistanceToLensCenter = 0.035
        screenToLensDistance = 0.042
        hasMagnet = true
        distortionCoefficients = [0.441, 0.156]
        leftEyeMaxFov = FieldOfView(angles: [40, 40, 40, 40])
        compressedRepresentation = Data()
    }
    
    public func getYEyeOffsetMeters(_ screen: ScreenParams) -> Float {
        switch verticalAlignment {
            case .center:
                return screen.widthMeters / Float(2);
            case .bottom:
                return verticalDistanceToLensCenter - screen.borderSizeMeters;
            case .top:
                return screen.widthMeters - (verticalDistanceToLensCenter - screen.borderSizeMeters);
        }
    }
    
    public static func fromUrl(_ url: String, onCompleted: @escaping (CardboardResult) -> Void) {
        URLResolver.resolve(url, onCompleted: { result in
            switch result {
            case .success(let string): onCompleted(fromBase64(string))
            case .failure(let error): onCompleted(.failure(error))
            }
        })
    }
    
    public static func fromData(_ data: NSData) -> CardboardResult {
        do {
            let headset = try Headset(serializedData: Data(referencing: data))
            let params = CardboardParams(root: headset, data: Data(referencing: data))
            return CardboardResult(value: params)
        } catch {
            return CardboardResult(error: .parserError("Failed to parse cardboard data using protobuf: \(error)"))
        }
    }
    
    public static func fromBase64(_ base64: String) -> CardboardResult {
        // Replace base64url chars with base64 chars.
        var safe = base64.replacingOccurrences(of: "-", with: "+",
            options: String.CompareOptions.literal, range: nil)
        safe = safe.replacingOccurrences(of: "_", with: "/",
            options: String.CompareOptions.literal, range: nil)
        while safe.characters.count % 4 != 0 {
            safe = safe + "="
        }
        
        guard let data = Data(base64Encoded: safe, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return CardboardResult(error: .base64DecodingError("Failed to decode base64 string: \(base64)"))
        }
        
        return fromData(data as NSData)
    }
}
