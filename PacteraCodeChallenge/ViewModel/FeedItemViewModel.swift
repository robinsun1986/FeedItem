//
//  FeedItemViewModel.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation
import UIKit

class FeedItemViewModel: NSObject {
    var title: String = ""
    var desc: String = ""
    var imageUrl: URL?
    
    override init() {
    }
    
    init(model: FeedItem) {
        self.title = model.title ?? ""
        self.desc = model.description ?? ""
        
        if let imageHref = model.imageHref {
            self.imageUrl = URL(string: imageHref)
        }
    }
}


