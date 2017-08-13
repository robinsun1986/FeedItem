//
//  FeedItemViewModelTests.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import XCTest

class FeedItemViewModelTests: XCTestCase {
    
    func testInit() {
        let feedItem1 = FeedItem()
        let feedItemViewModel1 = FeedItemViewModel(model: feedItem1)
        
        XCTAssertEqual(feedItemViewModel1.title, "")
        XCTAssertEqual(feedItemViewModel1.desc, "")
        XCTAssertNil(feedItemViewModel1.imageUrl)
        
        var feedItem2 = FeedItem()
        feedItem2.title = "title 123"
        feedItem2.description = "description 123"
        feedItem2.imageHref = "http://google.com.au"
        let feedItemViewModel2 = FeedItemViewModel(model: feedItem2)
        
        XCTAssertEqual(feedItemViewModel2.title, feedItem2.title)
        XCTAssertEqual(feedItemViewModel2.desc, feedItem2.description)
        XCTAssertEqual(feedItemViewModel2.imageUrl?.absoluteString, feedItem2.imageHref)
    }
    
}
