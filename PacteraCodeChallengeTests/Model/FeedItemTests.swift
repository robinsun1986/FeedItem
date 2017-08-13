//
//  FeedItemTests.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import XCTest

class FeedItemTests: XCTestCase {
    
    func testInit() {
        let title = "title1"
        let description = "description1"
        let imageHref = "http://google.com.au"
        
        let json = [
            "title": title,
            "description": description,
            "imageHref": imageHref
        ] as [String : Any?]
        
        let feedItem = FeedItem(json: json)
        
        XCTAssertEqual(feedItem.title, title)
        XCTAssertEqual(feedItem.description, description)
        XCTAssertEqual(feedItem.imageHref, imageHref)
    }
    
}
