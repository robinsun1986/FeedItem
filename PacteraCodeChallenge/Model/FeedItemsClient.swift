//
//  FeedItemsClient.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

protocol FeedItemsClient {
    func getFeedItems(completionHandler: @escaping ([String:Any]?, Error?) -> Void)
}

class FeedItemsClientImpl: FeedItemsClient {
    
    var feedItemsUrl = URL(string: kEndpointGetFeedItems)
    
    func getFeedItems(completionHandler: @escaping ([String:Any]?, Error?) -> Void) {
            
        if let feedItemsUrl = feedItemsUrl {
            
            let task = URLSession.shared.dataTask(with: feedItemsUrl) { (data, response, error) in
                if error != nil {
//                    print(error!)
                    completionHandler(nil, NSError(domain: "ApiError", code: 123, userInfo: [:]));
                } else {
                    var feedItems: [String: Any]?
                    
                    if let data = data {
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        feedItems = json as? [String: Any]
                    }
                    
                    if feedItems == nil {
                        completionHandler(nil, NSError(domain: "ApiError", code: 123, userInfo: [:]));
                    } else {
                        completionHandler(feedItems, nil);
                    }
                }
            }
            
            task.resume()
        }
    }
}
