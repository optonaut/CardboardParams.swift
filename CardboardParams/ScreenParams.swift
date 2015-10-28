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
        case IPhone4
        case IPhone4S
        case IPhone5
        case IPhone5C
        case IPhone5S
        case IPhone6Plus
        case IPhone6
        case IPhone6S
        case IPhone6SPlus
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
        case .IPhone4, .IPhone4S: self.init(width: 640, height: 960, diagonalInInch: 3.5)
        case .IPhone5, .IPhone5C, .IPhone5S: self.init(width: 640, height: 1136, diagonalInInch: 4)
        case .IPhone6Plus, .IPhone6SPlus: self.init(width: 1242, height: 2208, diagonalInInch: 5.5)
        case .IPhone6, .IPhone6S: self.init(width: 750, height: 1334, diagonalInInch: 4.7)
        }
    }
}
