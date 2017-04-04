//
//  CardboardParamsTests.swift
//  CardboardParamsTests
//
//  Created by Emi on 24/10/15.
//  Copyright © 2015 Optonaut. All rights reserved.
//

import XCTest
@testable import CardboardParams

class CardboardParamsTests: XCTestCase {
    
    let VROneData = Data(base64Encoded: "Cg1DYXJsIFplaXNzIEFHEgZWUiBPTkUdUI0XPSW28309KhAAAEhCAABIQgAASEIAAEhCWAE1KVwPPToIzczMPQAAgD9QAGAA", options: NSData.Base64DecodingOptions(rawValue: 0))!
    let VROneDataBase64 = "Cg1DYXJsIFplaXNzIEFHEgZWUiBPTkUdUI0XPSW28309KhAAAEhCAABIQgAASEIAAEhCWAE1KVwPPToIzczMPQAAgD9QAGAA"
    let OnePlusOneBase64 = "CgZHb29nbGUSEkNhcmRib2FyZCBJL08gMjAxNR2ZuxY9JbbzfT0qEAAASEIAAEhCAABIQgAASEJYADUpXA89OgiCc4Y-MCqJPlAAYAM"
    let OtherOnePlusOneBase64 = "Cg5JIEFNIENhcmRib2FyZBIVSUFDIEdpYW50IEVWQSBIZWFkc2V0HRKDQD0lbxKDPSoQAABIQgAASEIAAEhCAABIQlgANexROD06CAAAAAAAAAAAUAFgAQ"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExpandUrlAndGetData() {
        let url = "http://goo.gl/vvTUK3";
        
        let expectation = self.expectation(description: "Data Decoded")
        
        URLResolver.resolve(url, onCompleted: { result in
            XCTAssert(result.error == nil)
            XCTAssertEqual(result.value, self.VROneDataBase64)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }
    
    func testExpandUrlAndGetDataFactory() {
        let url = "http://goo.gl/vvTUK3";
        
        let expectation = self.expectation(description: "Data Decoded")
        
        CardboardParams.fromUrl(url, onCompleted: { result in
            
            expectation.fulfill()
            
            XCTAssert(result.error == nil)
            if let cardboard = result.value {
                XCTAssertEqual(cardboard.vendor, "Carl Zeiss AG")
                XCTAssertEqual(cardboard.model, "VR ONE")
                //                XCTAssertEqual(cardboard.compressedRepresentation, self.VROneData)
            } else {
                XCTAssert(false)
            }
        })
        
        waitForExpectations(timeout: 5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }
    
    
    func testDecodeDeviceFromUrlData() {
        let headset = CardboardParams.fromBase64(OnePlusOneBase64).value!
        
        XCTAssertEqual(headset.vendor, "Google")
        XCTAssertEqual(headset.model, "Cardboard I/O 2015")
    }
    
    func testDecodeDeviceFromOtherUrlData() {
        let headset = CardboardParams.fromBase64(OtherOnePlusOneBase64).value!
        
        XCTAssertEqual(headset.vendor, "I AM Cardboard")
        XCTAssertEqual(headset.model, "IAC Giant EVA Headset")
    }
    
    func testDecodeDeviceBase64Error() {
        let result = CardboardParams.fromBase64("Nonesense Data")
        XCTAssert(result.error != nil)
    }
    
    func testDecodeDeviceProtobufError() {
        let result = CardboardParams.fromBase64("Tm9uZXNlbnNlIERhdGE")
        XCTAssert(result.error != nil)
    }
    
    func testUrlResolveError() {
        
        let expectation = self.expectation(description: "Error cought")
        
        CardboardParams.fromUrl("asdf://nonesense_url", onCompleted: { result in
            XCTAssert(result.error != nil)
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }
    
    func testDecodeDeviceFromData() {
        let headset = try! Headset(serializedData: VROneData)
        
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
