//
//  GoogleCardboardParserTests.swift
//  GoogleCardboardParserTests
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import XCTest
@testable import GoogleCardboardParser

class GoogleCardboardParserTests: XCTestCase {
    
    var VROneData : NSData!
    let OnePlusOneBase64 = "CgZHb29nbGUSEkNhcmRib2FyZCBJL08gMjAxNR2ZuxY9JbbzfT0qEAAASEIAAEhCAABIQgAASEJYADUpXA89OgiCc4Y-MCqJPlAAYAM"
    
    override func setUp() {
        super.setUp()
        VROneData = NSData(base64EncodedString: "Cg1DYXJsIFplaXNzIEFHEgZWUiBPTkUdUI0XPSW28309KhAAAEhCAABIQgAASEIAAEhCWAE1KVwPPToIzczMPQAAgD9QAGAA", options: NSDataBase64DecodingOptions(rawValue: 0))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExpandUrlAndGetData() {
        let url = "http://goo.gl/vvTUK3";
        
        let expectation = expectationWithDescription("Data Decoded")
        
        UrlResolver.resolve(url, onCompleted: { data in
            XCTAssertEqual(data, self.VROneData)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(0.5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }
    
    func testDecodeDeviceFromUrlData() {
        let headset = CardboardFactory.CardboardParamsFromBase64(OnePlusOneBase64)
        
        print(headset)
        
        XCTAssertEqual(headset.vendor, "Google")
        XCTAssertEqual(headset.model, "Cardboard I/O 2015")
    }
    
    func testDecodeDeviceFromData() {
        let headset = try! Headset.parseFromData(VROneData)
        
        XCTAssertEqual(headset.vendor, "Carl Zeiss AG")
        XCTAssertEqual(headset.model, "VR ONE")
        XCTAssertEqual(headset.distortionCoefficients, [0.1, 1.0])
        XCTAssertEqual(headset.leftEyeFieldOfViewAngles, [50.0, 50.0, 50.0, 50.0])
        XCTAssertEqual(headset.screenToLensDistance, 0.037)
        XCTAssertEqual(headset.interLensDistance, 0.062)
        XCTAssertEqual(headset.hasMagnet, false)
        XCTAssertEqual(headset.verticalAlignment, 1)
        XCTAssertEqual(headset.primaryButton, 0)
    }
}
