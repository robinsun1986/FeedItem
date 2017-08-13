//
//  FeedItemViewModel.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 13/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import Foundation
import UIKit

class FeedItemViewModel: NSObject {
    var title: String = ""
    var desc: String = ""
    var imageUrl: URL?
    
    static let kTitleTopMargin: CGFloat = 15
    static let kTitleLeftMargin: CGFloat = 10
    static let kTitleRightMargin: CGFloat = -30
    static let kTitleImageMargin: CGFloat = 10
    static let kTitleDescriptionMargin: CGFloat = 5
    static let kDescriptionImageMargin: CGFloat = 15
    static let kBottomMargin: CGFloat = -15
    static let kPhotoImageWidth: CGFloat = 90
    static let kPhotoImageHeight: CGFloat = 60
    static let kArrowImageWidth: CGFloat = 18
    static let kArrowImageHeight: CGFloat = 18
    static let kArrowRightMargin: CGFloat = -5
    static let kImageArrowMargin: CGFloat = 5
    
    static let kPlaceholderImageName = "placeholder"
    static let kArrowImageName = "ic_keyboard_arrow_right_18pt"
    static let kTitleFont = UIFont(name: "Helvetica", size: 17)
    static let kDescriptionFont = UIFont(name: "Helvetica", size: 14)
    static let kTitleTextColor = UIColor(red: 44 / 255.0, green: 64 / 255.0, blue: 118 / 255.0, alpha: 1.0)
    static let kDescriptionTextColor = UIColor.black
    static let kScreenWidth = UIScreen.main.bounds.width
    
    override init() {
    }
    
    init(model: FeedItem) {
        self.title = model.title ?? ""
        self.desc = model.description ?? ""
        
        if let imageHref = model.imageHref {
            self.imageUrl = URL(string: imageHref)
        }
    }
    
    func estimatedCellHeight() -> CGFloat {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = FeedItemViewModel.kTitleFont
        titleLabel.text = title
        let titleLabelWidth = FeedItemViewModel.kScreenWidth - FeedItemViewModel.kTitleLeftMargin + FeedItemViewModel.kTitleRightMargin
        let titleLabelSize = titleLabel.sizeThatFits(CGSize(width: titleLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = FeedItemViewModel.kDescriptionFont
        descriptionLabel.text = desc
        let descriptionLabelWidth = titleLabelWidth - FeedItemViewModel.kPhotoImageWidth - FeedItemViewModel.kDescriptionImageMargin
        let descriptionLabelSize = descriptionLabel.sizeThatFits(CGSize(width: descriptionLabelWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let tallestHeightBetweenDescriptionAndImage = (descriptionLabelSize.height > FeedItemViewModel.kPhotoImageHeight ? descriptionLabelSize.height : FeedItemViewModel.kPhotoImageHeight)
        let cellHeight = FeedItemViewModel.kTitleTopMargin + titleLabelSize.height + FeedItemViewModel.kTitleDescriptionMargin + tallestHeightBetweenDescriptionAndImage - FeedItemViewModel.kBottomMargin
        
        return cellHeight
    }
}


