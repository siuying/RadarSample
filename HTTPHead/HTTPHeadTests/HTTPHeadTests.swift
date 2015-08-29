//
//  HTTPHeadTests.swift
//  HTTPHeadTests
//
//  Created by Chan Fai Chong on 29/8/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import XCTest
@testable import HTTPHead

class HTTPHeadTests: XCTestCase, NSURLSessionTaskDelegate {
    var session : NSURLSession!

    override func setUp() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 5.0
        session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    func testGet() {
        let expectation = self.expectationWithDescription("complete")
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bit.ly/1Ub9VBf")!)
        request.HTTPMethod = "GET"
        
        var error : NSError? = nil
        var response : NSURLResponse? = nil
        session.dataTaskWithRequest(request) { (data, _response, _error) -> Void in
            error = _error
            response = _response
            expectation.fulfill()
            }.resume()
        
        self.waitForExpectationsWithTimeout(10.0) { (_) -> Void in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
        }
    }
    
    /// Comment below will make the test pass
    func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void) {
        // disable redirect
        completionHandler(nil)
    }
}
