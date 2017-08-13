//
//  UIUtils.swift
//  SeekIOSCodingChallenge
//
//  Created by Robin Sun on 23/7/17.
//  Copyright © 2017 SEEK. All rights reserved.
//

import UIKit

class UIUtils: NSObject {
    static func alert(title: String, message: String, viewController: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(defaultAction)
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
