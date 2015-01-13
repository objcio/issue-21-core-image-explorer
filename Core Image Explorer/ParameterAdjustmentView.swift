//
//  ParameterAdjustmentView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/10/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

protocol ParameterAdjustmentDelegate {
    func parameterValueDidChange(param: ScalarFilterParameter)
}

class ParameterAdjustmentView: UIView {

    var parameters: [ScalarFilterParameter]!
    var sliderViews = [LabeledSliderView]()

    func setAdjustmentDelegate(delegate: ParameterAdjustmentDelegate) {
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
        var yOffset: CGFloat = 8
        for param in parameters {

            let frame = CGRectMake(0, yOffset, bounds.size.width, 62)

            let sliderView = LabeledSliderView(frame: frame, parameter: param)
            sliderView.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(sliderView)

            sliderViews.append(sliderView)

            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Leading, relatedBy: .Equal,
                                             toItem: self, attribute: .Leading, multiplier: 1, constant: 20))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Top, relatedBy: .Equal,
                                             toItem: self, attribute: .Top, multiplier: 1, constant: yOffset))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Width, relatedBy: .Equal,
                                             toItem: self, attribute: .Width, multiplier: 1, constant: -40))
            addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Height, relatedBy: .Equal,
                                             toItem: self, attribute: .Height, multiplier: 0, constant: 62))

            yOffset += 70
        }
    }
}

