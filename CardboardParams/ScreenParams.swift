//
//  ScreenParams.swift
//  CardboardParams
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public struct ScreenParams {

    public enum Device {
        case iPhone4
        case iPhone4S
        case iPhone5
        case iPhone5C
        case iPhone5S
        case iPhone6Plus
        case iPhone6
        case iPhone6S
        case iPhone6SPlus
    }
    
    static let DefaultBorderSizeInMeters = Float(0.003)
    public static let MetersPerInch = Float(0.0254)
    
    public let width: Int
    public let height: Int
    
    public let borderSizeMeters: Float
    public let widthMeters: Float
    public let heightMeters: Float
    
    public init(width: Int, height: Int, widthMeters: Float, heightMeters: Float, borderSizeMeters: Float = ScreenParams.DefaultBorderSizeInMeters) {
        self.width = width
        self.height = height
        self.widthMeters = widthMeters
        self.heightMeters = heightMeters
        self.borderSizeMeters = borderSizeMeters
    }
    
    public init(width: Int, height: Int, diagonalInInch: Float, borderSizeInMeters: Float = ScreenParams.DefaultBorderSizeInMeters) {
        let diag = sqrt(Float(width * width + height * height))
        let wInch = diagonalInInch / diag * Float(width)
        let hInch = diagonalInInch / diag * Float(height)
        
        self.width = width
        self.height = height
        self.borderSizeMeters = borderSizeInMeters
        self.widthMeters = wInch * ScreenParams.MetersPerInch
        self.heightMeters = hInch * ScreenParams.MetersPerInch
    }
    
    public init(device: Device) {
        switch device {
        case .iPhone4, .iPhone4S: self.init(width: 640, height: 960, diagonalInInch: 3.5)
        case .iPhone5, .iPhone5C, .iPhone5S: self.init(width: 640, height: 1136, diagonalInInch: 4)
        case .iPhone6Plus, .iPhone6SPlus: self.init(width: 1242, height: 2208, diagonalInInch: 5.5)
        case .iPhone6, .iPhone6S: self.init(width: 750, height: 1334, diagonalInInch: 4.7)
        }
    }
}
