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
    var parameter: ScalarFilterParameter!
    var delegate: ParameterAdjustmentDelegate?

    init(frame: CGRect, parameter: ScalarFilterParameter) {
        super.init(frame: frame)

        self.parameter = parameter

        addSubviews()
        addLayoutConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        slider = UISlider(frame: frame)
        slider.minimumValue = parameter.minimumValue!
        slider.maximumValue = parameter.maximumValue!
        slider.value = parameter.currentValue
        slider.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(slider)

        slider.addTarget(self, action: "sliderTouchUpInside:", forControlEvents: .TouchUpInside)
        slider.addTarget(self, action: "sliderValueDidChange:", forControlEvents: .ValueChanged)

        descriptionLabel = UILabel(frame: frame)
        descriptionLabel.font = UIFont.boldSystemFontOfSize(14)
        descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        descriptionLabel.text = parameter.name
        descriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(descriptionLabel)

        valueLabel = UILabel(frame: frame)
        valueLabel.font = UIFont.systemFontOfSize(14)
        valueLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        valueLabel.textAlignment = .Right
        valueLabel.text = slider.value.description
        valueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(valueLabel)
    }

    func addLayoutConstraints() {
        addConstraint(NSLayoutConstraint(item: slider, attribute: .Width, relatedBy: .Equal,
            toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .Height, relatedBy: .Equal,
            toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .Bottom, relatedBy: .Equal,
            toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .Leading, relatedBy: .Equal,
            toItem: self, attribute: .Leading, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Top, relatedBy: .Equal,
            toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Height, relatedBy: .Equal,
            toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Width, relatedBy: .Equal,
            toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Leading, relatedBy: .Equal,
            toItem: self, attribute: .Leading, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .Top, relatedBy: .Equal,
            toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .Height, relatedBy: .Equal,
            toItem: self, attribute: .Height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .Width, relatedBy: .Equal,
            toItem: self, attribute: .Width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .Leading, relatedBy: .Equal,
            toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
    }

    func sliderValueDidChange(sender: AnyObject?) {
        valueLabel.text = String(format: "%0.2f", slider.value)
    }

    func sliderTouchUpInside(sender: AnyObject?) {
        if delegate != nil {
            delegate!.parameterValueDidChange(ScalarFilterParameter(key: parameter.key, value: slider.value))
        }
    }
}
