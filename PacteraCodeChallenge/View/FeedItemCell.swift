//
//  FeedItemCell.swift
//  SDWebImageTest
//
//  Created by Robin Sun on 12/8/17.
//  Copyright © 2017 abc. All rights reserved.
//

import UIKit

class FeedItemCell: UITableViewCell {

    var titleLabel: UILabel = UILabel()
    var descriptionLabel: UILabel = UILabel()
    var photoImageView: RobinImageView = RobinImageView()
    var arrowImageView: UIImageView = UIImageView()
    var bottomConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupSeparator()
        setupTitleLabel()
        setupDescriptionLabel()
        setupPhotoImageView()
        setupArrow()
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
    
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = FeedItemViewModel.kTitleFont
        titleLabel.textColor = FeedItemViewModel.kTitleTextColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: FeedItemViewModel.kTitleTopMargin)
        let titleLabelLeftConstraint = NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: FeedItemViewModel.kTitleLeftMargin)
        let titleLabelRightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: FeedItemViewModel.kTitleRightMargin)
        contentView.addConstraints([titleLabelTopConstraint, titleLabelLeftConstraint, titleLabelRightConstraint])
    }
    
    private func setupDescriptionLabel() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.font = FeedItemViewModel.kDescriptionFont
        descriptionLabel.textColor = FeedItemViewModel.kDescriptionTextColor
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let descriptionLabelTopConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: FeedItemViewModel.kTitleDescriptionMargin)
        let descriptionLabelLeftConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1.0, constant: 0)
        contentView.addConstraints([descriptionLabelTopConstraint, descriptionLabelLeftConstraint])
    }
    
    private func setupPhotoImageView() {
        contentView.addSubview(photoImageView)
        photoImageView.contentMode = .scaleAspectFit
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        let photoImageViewWidth = NSLayoutConstraint(item: photoImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FeedItemViewModel.kPhotoImageWidth)
        let photoImageViewHeight = NSLayoutConstraint(item: photoImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FeedItemViewModel.kPhotoImageHeight)
        photoImageView.addConstraints([photoImageViewWidth, photoImageViewHeight])
        
        let photoImageViewTopConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .top, multiplier: 1.0, constant: 0)
        let photoImageViewRightConstraint = NSLayoutConstraint(item: photoImageView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1.0, constant: 0)
        let photoImageViewLeftConstraint = NSLayoutConstraint(item: photoImageView, attribute: .left, relatedBy: .equal, toItem: descriptionLabel, attribute: .right, multiplier: 1.0, constant: FeedItemViewModel.kDescriptionImageMargin)
        contentView.addConstraints([photoImageViewTopConstraint, photoImageViewRightConstraint, photoImageViewLeftConstraint])
    }
    
    private func setupArrow() {
        contentView.addSubview(arrowImageView)
        arrowImageView.contentMode = .scaleAspectFit
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let arrowImageViewWidth = NSLayoutConstraint(item: arrowImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FeedItemViewModel.kArrowImageWidth)
        let arrowImageViewHeight = NSLayoutConstraint(item: arrowImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: FeedItemViewModel.kArrowImageHeight)
        arrowImageView.addConstraints([arrowImageViewWidth, arrowImageViewHeight])
        
        let arrowImageViewRightConstraint = NSLayoutConstraint(item: arrowImageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: FeedItemViewModel.kArrowRightMargin)
        let arrowImageCenterYConstraint = NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
        contentView.addConstraints([arrowImageViewRightConstraint, arrowImageCenterYConstraint])
    }
    
    func configure(viewModel: FeedItemViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.desc
        photoImageView.setImage(url: viewModel.imageUrl, placeholerImage: UIImage(named: FeedItemViewModel.kPlaceholderImageName))
        arrowImageView.image = UIImage(named: FeedItemViewModel.kArrowImageName)
    }
}
