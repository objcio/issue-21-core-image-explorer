//
//  PhotoFilterCollectionViewCell.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/12/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

let kCellWidth: CGFloat = 66
let kLabelHeight: CGFloat = 20

class PhotoFilterCollectionViewCell: UICollectionViewCell {
    var filterNameLabel: UILabel!
    var filteredImageView: FilteredImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(kCellWidth, kCellWidth + kLabelHeight);
    }

    func addSubviews() {
        if (filteredImageView == nil) {
            filteredImageView = FilteredImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            filteredImageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(filteredImageView)
        }

        if (filterNameLabel == nil) {
            filterNameLabel = UILabel(frame: CGRectMake(0, kCellWidth, kCellWidth, kLabelHeight))
            filterNameLabel.textAlignment = .Center
            filterNameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            filterNameLabel.highlightedTextColor = tintColor
            filterNameLabel.font = UIFont.systemFontOfSize(12)
            contentView.addSubview(filterNameLabel)
        }
    }

    override var selected: Bool {
        didSet {
            filteredImageView.layer.borderWidth = selected ? 2 : 0
        }
    }
}
