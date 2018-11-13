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
        super.init(coder: aDecoder)!
        addSubviews()
    }

    override var intrinsicContentSize : CGSize {
        return CGSize(width: kCellWidth, height: kCellWidth + kLabelHeight);
    }

    func addSubviews() {
        if (filteredImageView == nil) {
            filteredImageView = FilteredImageView(frame: CGRect(x: 0, y: 0, width: kCellWidth, height: kCellWidth))
            filteredImageView.layer.borderColor = tintColor.cgColor
            contentView.addSubview(filteredImageView)
        }

        if (filterNameLabel == nil) {
            filterNameLabel = UILabel(frame: CGRect(x: 0, y: kCellWidth, width: kCellWidth, height: kLabelHeight))
            filterNameLabel.textAlignment = .center
            filterNameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            filterNameLabel.highlightedTextColor = tintColor
            filterNameLabel.font = UIFont.systemFont(ofSize: 12)
            contentView.addSubview(filterNameLabel)
        }
    }

    override var isSelected: Bool {
        didSet {
            filteredImageView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
}
