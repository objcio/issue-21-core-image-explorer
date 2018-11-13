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
        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)

        slider.addTarget(self, action: #selector(LabeledSliderView.sliderTouchUpInside(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(LabeledSliderView.sliderValueDidChange(_:)), for: .valueChanged)

        descriptionLabel = UILabel(frame: frame)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        descriptionLabel.text = parameter.name
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)

        valueLabel = UILabel(frame: frame)
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
        valueLabel.textAlignment = .right
        valueLabel.text = slider.value.description
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
    }

    func addLayoutConstraints() {
        addConstraint(NSLayoutConstraint(item: slider, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: valueLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1, constant: 0))
    }

    @objc func sliderValueDidChange(_ sender: AnyObject?) {
        valueLabel.text = String(format: "%0.2f", slider.value)
    }

    @objc func sliderTouchUpInside(_ sender: AnyObject?) {
        if delegate != nil {
            delegate!.parameterValueDidChange(ScalarFilterParameter(key: parameter.key, value: slider.value))
        }
    }
}
