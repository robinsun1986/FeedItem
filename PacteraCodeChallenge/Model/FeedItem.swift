//
//  FeedItem.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation

struct FeedItem {
    var title: String?
    var description: String?
    var imageHref: String?
    
    init() {
    }
    
    init(json: [String:Any?]) {
        self.title = json["title"] as? String
        self.description = json["description"] as? String
        self.imageHref = json["imageHref"] as? String
    }
}

