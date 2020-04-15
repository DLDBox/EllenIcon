//
//  JobTestTests.swift
//  JobTestTests
//
//  Created by Dana Devoe on 5/11/17.
//  Copyright © 2017 Dana Devoe. All rights reserved.
//

import XCTest
@testable import JobTest

class JobTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCloudFront() {
        let exception = expectation(description: "Timeout loading image from CloudFront")
        
        CloudFrontService.getPayLoad( urlString: urls.images.payload, success: { (payload) in
            
            if var imageInfo = payload[0] {
                
                CloudFrontService.retreiveImages(urlString: imageInfo.url , success: { (image) in
                    imageInfo.image = image
                    print( "loadimage = \(image)" )
                    exception.fulfill()
                }, failure: { (error) in
                    print( "There was an error \(error)" )
                })
                
            }
            
        }, failure: { (error) in
            print( "There was an error \(error)" )
        } )
        
        self.waitForExpectations(timeout: 300, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
