//
//  LabeledSliderView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/10/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class LabeledSliderView: UIView {
    var slider: UISlider!
    var descriptionLabel: UILabel!
    var valueLabel: UILabel!
    var key: String!
    var delegate: ParameterAdjustmentDelegate?

    init(frame: CGRect, parameter: ScalarFilterParameter) {
        super.init(frame: frame)

        self.key = parameter.key

        self.slider = UISlider(frame: frame)
        self.slider.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.slider.minimumValue = parameter.minimumValue!
        self.slider.maximumValue = parameter.maximumValue!
        self.slider.value = parameter.currentValue

        self.addSubview(self.slider)

        self.slider.addTarget(self, action: "sliderTouchUpInside:", forControlEvents: .TouchUpInside)
        self.slider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)

        self.descriptionLabel = UILabel(frame: frame)
        self.descriptionLabel.font = UIFont.boldSystemFontOfSize(14)
        self.descriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.descriptionLabel.text = parameter.name
        self.addSubview(self.descriptionLabel)

        self.valueLabel = UILabel(frame: frame)
        self.valueLabel.font = UIFont.systemFontOfSize(14)
        self.valueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.valueLabel.textAlignment = .Right
        self.valueLabel.text = self.slider.value.description
        self.addSubview(self.valueLabel)

        self.addConstraint(NSLayoutConstraint(item: self.slider, attribute: .Width, relatedBy: .Equal,
                                              toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.slider, attribute: .Height, relatedBy: .Equal,
                                              toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.slider, attribute: .Bottom, relatedBy: .Equal,
                                              toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.slider, attribute: .Leading, relatedBy: .Equal,
                                              toItem: self, attribute: .Leading, multiplier: 1, constant: 0))

        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .Top, relatedBy: .Equal,
                                              toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .Height, relatedBy: .Equal,
                                              toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .Width, relatedBy: .Equal,
                                              toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .Leading, relatedBy: .Equal,
                                              toItem: self, attribute: .Leading, multiplier: 1, constant: 0))

        self.addConstraint(NSLayoutConstraint(item: self.valueLabel, attribute: .Top, relatedBy: .Equal,
                                              toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.valueLabel, attribute: .Height, relatedBy: .Equal,
                                              toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.valueLabel, attribute: .Width, relatedBy: .Equal,
                                              toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.valueLabel, attribute: .Leading, relatedBy: .Equal,
                                              toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func sliderValueDidChange(sender: AnyObject?) {
        self.valueLabel.text = String(format: "%0.2f", self.slider.value)
    }

    func sliderTouchUpInside(sender: AnyObject?) {
        if self.delegate != nil {
            self.delegate!.parameterValueDidChange(ScalarFilterParameter(key: self.key, value: self.slider.value))
        }
    }
}
