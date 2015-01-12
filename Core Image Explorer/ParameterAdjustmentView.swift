//
//  ParameterAdjustmentView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/10/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

struct ScalarFilterParameter
{
    var name: String?
    var key: String
    var minimumValue: Float?
    var maximumValue: Float?
    var currentValue: Float

    init(key: String, value: Float) {
        self.key = key
        self.currentValue = value
    }

    init(name: String, key: String, minimumValue: Float, maximumValue: Float, currentValue: Float)
    {
        self.name = name
        self.key = key
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.currentValue = currentValue
    }
}

protocol ParameterAdjustmentDelegate {
    func parameterValueDidChange(param: ScalarFilterParameter)
}

class ParameterAdjustmentView: UIView {

    var sliderViews = [LabeledSliderView]()

    func setAdjustmentDelegate(delegate: ParameterAdjustmentDelegate) {
        for sliderView in self.sliderViews {
            sliderView.delegate = delegate
        }
    }

    init(frame: CGRect, parameters: [ScalarFilterParameter]) {
        super.init(frame: frame)

        var yOffset: CGFloat = 8
        for param in parameters {

            let frame = CGRectMake(0, yOffset, self.bounds.size.width, 62)

            let sliderView = LabeledSliderView(frame: frame, parameter: param)
            sliderView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(sliderView)

            self.sliderViews.append(sliderView)

            self.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Leading, relatedBy: .Equal,
                                                  toItem: self, attribute: .Leading, multiplier: 1, constant: 8))
            self.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Top, relatedBy: .Equal,
                                                  toItem: self, attribute: .Top, multiplier: 1, constant: yOffset))
            self.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Width, relatedBy: .Equal,
                                                  toItem: self, attribute: .Width, multiplier: 1, constant: -16))
            self.addConstraint(NSLayoutConstraint(item: sliderView, attribute: .Height, relatedBy: .Equal,
                                                  toItem: self, attribute: .Height, multiplier: 0, constant: 62))

            yOffset += 70
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

