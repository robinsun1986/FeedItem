//
//  RobinLoadImageOperation.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation
import UIKit

protocol RobinLoadImageOperationDelegate: class {
    func didGetImageSuccess(img: UIImage)
    func didGetImageFailure(err: Error)
}

class RobinLoadImageOperation: Operation {
    
    private var url: URL
    weak var delegate: RobinLoadImageOperationDelegate?
    
    init(url: URL) {
        self.url = url
    }
    
    override func main() {
        let cachedImage = RobinWebImageManager.shared.getCachedImage(url: url)
        if (cachedImage == nil) {
            //  download image
            RobinWebImageManager.shared.downloadImage(url: url, successHandler: { (image) in
                delegate?.didGetImageSuccess(img: image)
            }, errorHandler: { (err) in
                delegate?.didGetImageFailure(err: err)
            })
        } else {
            delegate?.didGetImageSuccess(img: cachedImage!)
        }
    }
}
