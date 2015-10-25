//
//  CardboardParams.swift
//  GoogleCardboardParser
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

enum VerticalAlignment: Int32 {
    case Bottom = 0
    case Center = 1
    case Top = 2
}

struct CardboardParams {
    
    let vendor: String
    let model: String
    let interLensDistance: Float
    let verticalAlignment: VerticalAlignment
    let verticalDistanceToLensCenter: Float
    let screenToLensDistance: Float
    let leftEyeMaxFov: FieldOfView
    let hasMagnet: Bool
    let distortionCoefficients: [Float]
    
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
    
    init() {
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
    
    func getYEyeOffsetMeters(screen: ScreenParams) -> Float {
        switch verticalAlignment {
            case .Center:
                return screen.heightMeters / Float(2);
            case .Bottom:
                return verticalDistanceToLensCenter - screen.borderSizeMeters;
            case .Top:
                return screen.heightMeters - (verticalDistanceToLensCenter - screen.borderSizeMeters);
        }
    }
}