//
//  RobinImageView.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation
import UIKit

class RobinImageView: UIImageView, RobinLoadImageOperationDelegate {
    private var currentOperation: RobinLoadImageOperation?
    
    func setImage(url: URL?, placeholerImage: UIImage?) {
        self.currentOperation?.cancel()
        self.image = placeholerImage
        
        if let url = url {
            let operation = RobinLoadImageOperation(url: url)
            operation.delegate = self
            self.currentOperation = operation
            RobinWebImageManager.shared.addLoadImageOperation(operation: operation)
        }
    }
    
    func didGetImageFailure(err: Error) {
        // Do nothing
        
    }
    
    func didGetImageSuccess(img: UIImage) {
        DispatchQueue.main.async {
            self.image = img
        }
    }
}
