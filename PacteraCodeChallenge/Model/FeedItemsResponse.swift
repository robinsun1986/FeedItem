//
//  FeedItemsResponse.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

struct FeedItemsResponse {
    var rows: Array<FeedItem>?
    
    init(json: [String:Any?]) {
        if let rows = json["rows"] as? Array<Any?> {
            var rowArray = Array<FeedItem>()
            
            for rowDict in rows {
                if let rowDict = rowDict as? [String:Any?] {
                    let feedItem = FeedItem(json: rowDict)
                    rowArray.append(feedItem)
                }
            }
            
            self.rows = rowArray
        }
    }
}
