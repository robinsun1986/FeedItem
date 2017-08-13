//
//  FeedItemsResponseTests.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import XCTest

class FeedItemsResponseTests: XCTestCase {
    
    func testInit() {
        let title1 = "title1"
        let description1 = "description1"
        let imageHref1 = "http://google.com.au"
        
        let title2 = "title2"
        let description2 = "description2"
        let imageHref2 = "http://facebook.com"
        
        let json = [
            "rows": [
                [
                    "title": title1,
                    "description": description1,
                    "imageHref": imageHref1
                ], [
                    "title": title2,
                    "description": description2,
                    "imageHref": imageHref2
                ]
            ]
        ] as [String : Any?]
        
        let response = FeedItemsResponse(json: json)
        XCTAssertEqual(response.rows?.count, 2)
        XCTAssertNotNil(response.rows?[0])
        XCTAssertNotNil(response.rows?[1])
    }
    
}
