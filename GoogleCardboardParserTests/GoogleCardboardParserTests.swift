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
    
    let VROneData = NSData(base64EncodedString: "Cg1DYXJsIFplaXNzIEFHEgZWUiBPTkUdUI0XPSW28309KhAAAEhCAABIQgAASEIAAEhCWAE1KVwPPToIzczMPQAAgD9QAGAA", options: NSDataBase64DecodingOptions(rawValue: 0))
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
        
        let expectation = expectationWithDescription("Data Decoded")
        
        URLResolver.resolve(url, onCompleted: { data, error in
            XCTAssert(error == nil)
            XCTAssertEqual(data, self.VROneData)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }
    
    func testExpandUrlAndGetDataFactory() {
        let url = "http://goo.gl/vvTUK3";
        
        let expectation = expectationWithDescription("Data Decoded")
        
        CardboardFactory.CardboardParamsFromUrl(url, onCompleted: { cardboard, error in

            expectation.fulfill()
            
            XCTAssert(error != nil)
            if let cardboard = cardboard {
                XCTAssertEqual(cardboard.vendor, "Carl Zeiss AG")
                XCTAssertEqual(cardboard.model, "VR ONE")
                XCTAssertEqual(cardboard.compressedRepresentation, self.VROneData)
            } else {
                XCTAssert(false)
            }
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
    }

    
    func testDecodeDeviceFromUrlData() {
        let headset = try! CardboardFactory.CardboardParamsFromBase64(OnePlusOneBase64)!
        
        XCTAssertEqual(headset.vendor, "Google")
        XCTAssertEqual(headset.model, "Cardboard I/O 2015")
    }
    
    func testDecodeDeviceFromOtherUrlData() {
        let headset = try! CardboardFactory.CardboardParamsFromBase64(OtherOnePlusOneBase64)!
        
        XCTAssertEqual(headset.vendor, "I AM Cardboard")
        XCTAssertEqual(headset.model, "IAC Giant EVA Headset")
    }
    
    func testDecodeDeviceBase64Error() {
        do {
            _ = try CardboardFactory.CardboardParamsFromBase64("Nonesense Data")!
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
    
    func testDecodeDeviceProtobufError() {
        do {
            _ = try CardboardFactory.CardboardParamsFromBase64("Tm9uZXNlbnNlIERhdGE=")!
            XCTAssert(false)
        } catch {
            XCTAssert(true)
        }
    }
    
    func testUrlResolveError() {
        
        let expectation = expectationWithDescription("Error cought")
        
        CardboardFactory.CardboardParamsFromUrl("asdf://nonesense_url", onCompleted: { cardboard, error in
            XCTAssert(error != nil)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            if error != nil {
                XCTAssert(false, "Timeout")
            }
        })
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
