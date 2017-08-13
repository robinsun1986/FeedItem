//
//  FeedItemCell.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class FeedItemCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSeparator()
    }
    
    private func setupSeparator() {
        if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            separatorInset = .zero
        }
        
        if responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins))  {
            preservesSuperviewLayoutMargins = false
        }
        
        if responds(to: #selector(setter: UIView.layoutMargins))  {
            layoutMargins = .zero
        }
    }
}
