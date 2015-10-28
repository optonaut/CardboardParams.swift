//
//  FieldOfFiew.swift
//  CardboardParams
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public struct FieldOfView {
    
    public let angles: [Float]
    public let left: Float
    public let right: Float
    public let top: Float
    public let bottom: Float
    
    public init(angles: [Float]) {
        guard angles.count == 4 else {
            fatalError("FieldOfView expects four angles.")
        }
        self.angles = angles
        self.left = angles[0]
        self.right = angles[1]
        self.top = angles[2]
        self.bottom = angles[3]
    }
}
