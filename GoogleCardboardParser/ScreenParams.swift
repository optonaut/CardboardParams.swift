//
//  ScreenParams.swift
//  GoogleCardboardParser
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public struct ScreenParams {
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
    
    public static let iPhone6Plus = ScreenParams(width: 1242, height: 2208, diagonalInInch: 5.5)
    public static let iPhone6 = ScreenParams(width: 750, height: 1334, diagonalInInch: 4.7)
    public static let iPhone5 = ScreenParams(width: 640, height: 1136, diagonalInInch: 4)
    public static let iPhone5s = ScreenParams(width: 640, height: 1136, diagonalInInch: 4)
    public static let iPhone4 = ScreenParams(width: 640, height: 960, diagonalInInch: 3.5)
}