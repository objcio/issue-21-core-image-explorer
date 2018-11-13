//
//  ParameterAdjustmentView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/10/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

let kSliderMarginX: CGFloat = 20
let kSliderMarginY: CGFloat = 8
let kSliderHeight: CGFloat = 48

protocol ParameterAdjustmentDelegate {
    func parameterValueDidChange(_ param: ScalarFilterParameter)
}

class ParameterAdjustmentView: UIView {

    var parameters: [ScalarFilterParameter]!
    var sliderViews = [LabeledSliderView]()

    func setAdjustmentDelegate(_ delegate: ParameterAdjustmentDelegate) {
        for sliderView in sliderViews {
            sliderView.delegate = delegate
        }
    }

    init(frame: CGRect, parameters: [ScalarFilterParameter]) {
        super.init(frame: frame)

        self.parameters = parameters

        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        var yOffset: CGFloat = kSliderMarginY
        for param in parameters {

            let frame = CGRect(x: 0, y: yOffset, width: bounds.size.width, height: kSliderHeight)

            let sliderView = LabeledSliderView(frame: frame, parameter: param)
            sliderView.translatesAutoresizingMaskIntoConstraints=false
            addSubview(sliderView)

            sliderViews.append(sliderView)

            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .leading, relatedBy: .equal,
                                             toItem: self, attribute: .leading, multiplier: 1, constant: kSliderMarginX))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal,
                                             toItem: self, attribute: .top, multiplier: 1, constant: yOffset))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .width, relatedBy: .equal,
                                             toItem: self, attribute: .width, multiplier: 1, constant: -kSliderMarginX * 2))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal,
                                             toItem: self, attribute: .height, multiplier: 0, constant: kSliderHeight))

            yOffset += (kSliderHeight + kSliderMarginY)
        }
    }
}

