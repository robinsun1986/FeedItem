//
//  FeedItemsViewModelTests.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import XCTest

class FeedItemsClientMockImpl: FeedItemsClient {
    func getFeedItems(completionHandler: @escaping ([String:Any]?, Error?) -> Void) {
        let json = [
            "rows": [
                [
                    "title": "title1",
                    "description": "description1",
                    "imageHref": "http://www.google.com.au"
                ], [
                    "title": "title2",
                    "description": "description2",
                    "imageHref": "http://www.facebook.com"
                ]
            ]
        ] as [String : Any]
        
        completionHandler(json, nil)
    }
}

class FeedItemsViewModelTests: XCTestCase {
    
    func testNumOfRows() {
        let feedItemsViewModel = FeedItemsViewModel()
        feedItemsViewModel.feedItemViewModels = [
            FeedItemViewModel(model: FeedItem()),
            FeedItemViewModel(model: FeedItem()),
            FeedItemViewModel(model: FeedItem())]
        XCTAssertEqual(feedItemsViewModel.numOfRows(), 3)
    }
    
    func testItemAt() {
        let feedItemsViewModel = FeedItemsViewModel()
        let itemViewModel1 = FeedItemViewModel(model: FeedItem())
        let itemViewModel2 = FeedItemViewModel(model: FeedItem())
        let itemViewModel3 = FeedItemViewModel(model: FeedItem())
        feedItemsViewModel.feedItemViewModels = [itemViewModel1, itemViewModel2, itemViewModel3]
        
        XCTAssertTrue(feedItemsViewModel.item(at: 0) == itemViewModel1)
        XCTAssertTrue(feedItemsViewModel.item(at: 1) == itemViewModel2)
        XCTAssertTrue(feedItemsViewModel.item(at: 2) == itemViewModel3)
    }
    
    func testGetFeedItems() {
        let feedItemsViewModel = FeedItemsViewModel()
        feedItemsViewModel.feedItemsClient = FeedItemsClientMockImpl()
        feedItemsViewModel.getFeedItems()
        sleep(1)
        
        XCTAssertEqual(feedItemsViewModel.feedItemViewModels.count, 2)
        let feedItemViewModel1 = feedItemsViewModel.feedItemViewModels[0]
        XCTAssertNotNil(feedItemViewModel1)
        XCTAssertEqual(feedItemViewModel1.title, "title1")
        XCTAssertEqual(feedItemViewModel1.desc, "description1")
        XCTAssertEqual(feedItemViewModel1.imageUrl?.absoluteString, "http://www.google.com.au")
        
        let feedItemViewModel2 = feedItemsViewModel.feedItemViewModels[1]
        XCTAssertNotNil(feedItemViewModel2)
        XCTAssertEqual(feedItemViewModel2.title, "title2")
        XCTAssertEqual(feedItemViewModel2.desc, "description2")
        XCTAssertEqual(feedItemViewModel2.imageUrl?.absoluteString, "http://www.facebook.com")
    }
}
