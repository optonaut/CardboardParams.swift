//
//  CardboardParams.swift
//  GoogleCardboardParser
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public enum VerticalAlignment: Int32 {
    case Bottom = 0
    case Center = 1
    case Top = 2
}

public struct CardboardParams {
    
    public let vendor: String
    public let model: String
    public let interLensDistance: Float
    public let verticalAlignment: VerticalAlignment
    public let verticalDistanceToLensCenter: Float
    public let screenToLensDistance: Float
    public let leftEyeMaxFov: FieldOfView
    public let hasMagnet: Bool
    public let distortionCoefficients: [Float]
    
    internal init(root: Headset) {
        vendor = root.vendor
        model = root.model
        interLensDistance = root.interLensDistance
        verticalAlignment = VerticalAlignment(rawValue: root.verticalAlignment)!
        verticalDistanceToLensCenter = root.trayToLensDistance
        hasMagnet = root.hasMagnet
        distortionCoefficients = root.distortionCoefficients
        screenToLensDistance = root.screenToLensDistance
        leftEyeMaxFov = FieldOfView(angles: root.leftEyeFieldOfViewAngles)
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
}