//
//  FeedItemsViewModel.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

protocol FeedItemsViewModelDelegate: class {
    func getFeedItemsOnSuccess()
    func getFeedItemsOnFailure(errMsg: String)
    func refreshOnComplete()
}

class FeedItemsViewModel: NSObject {
    static let kCellId = "FeedItemCell"
    static let kPageTitle = "Feed Items"
    
    weak var delegate: FeedItemsViewModelDelegate?
    var feedItemsClient: FeedItemsClient = FeedItemsClientImpl()
    var feedItemViewModels = Array<FeedItemViewModel>()
    
    // get number of feed items
    func numOfRows() -> Int {
        return feedItemViewModels.count
    }
    
    // get saved job model view at a particular index
    func item(at index: Int) -> FeedItemViewModel {
        return feedItemViewModels[index]
    }
    
    // get feed items
    func getFeedItems(isRefresh: Bool = false) {
        feedItemsClient.getFeedItems { (json, error) in
            if let error = error {
                self.delegate?.getFeedItemsOnFailure(errMsg: error.localizedDescription)
            } else {
                if let json = json {
                    let feedItemsResponse = FeedItemsResponse(json: json)
                    
                    var newFeedItems = Array<FeedItemViewModel>()
                    
                    if let rows = feedItemsResponse.rows {
                        for row in rows {
                            let feedItemViewModel = FeedItemViewModel(model: row)
                            newFeedItems.append(feedItemViewModel)
                        }
                    }
                    
                    self.feedItemViewModels = newFeedItems
                    self.delegate?.getFeedItemsOnSuccess()
                    if isRefresh {
                        self.delegate?.refreshOnComplete()
                    }
                }
            }
        }
    }
}



