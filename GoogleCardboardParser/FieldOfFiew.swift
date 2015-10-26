//
//  FieldOfFiew.swift
//  GoogleCardboardParser
//
//  Created by Emi on 25/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import Foundation

public struct FieldOfView {
    
    let angles: [Float]
    
    public init(angles: [Float]) {
        guard angles.count == 4 else {
            fatalError("FieldOfView expects four angles.")
        }
        self.angles = angles
    }
}