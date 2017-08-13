//
//  FeedItemsClientTests.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import XCTest

class FeedItemsClientTests: XCTestCase {
    func testGetFeedItems() {
        let bundle = Bundle(for: FeedItemsClientTests.self)
        let mockUrl = bundle.url(forResource: "MockFeedItems", withExtension: "json")
        let feedItemClient = FeedItemsClientImpl()
        feedItemClient.feedItemsUrl = mockUrl
        
        XCTAssertNotNil(feedItemClient.feedItemsUrl)
        
        feedItemClient.getFeedItems { (json, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(json)
            
            if let json = json {
                let rows = json["rows"] as? Array<[String: AnyObject?]>
                XCTAssertNotNil(rows)
                
                if let rows = rows {
                    XCTAssertEqual(rows.count, 10)
                    let lastRow = rows[9]
                    XCTAssertNotNil(lastRow)
                    
                    let title = lastRow["title"] as? String
                    let description = lastRow["description"] as? String
                    let imageHref = lastRow["imageHref"] as? String
                    
                    XCTAssertEqual(title, "Item 10")
                    XCTAssertEqual(description, "Lorem ipsum excepteur veniam anim anim.")
                    XCTAssertEqual(imageHref, "https://dummyimage.com/wideskyscraper")
                }
            }
        }
        
        sleep(3)
    }
}
