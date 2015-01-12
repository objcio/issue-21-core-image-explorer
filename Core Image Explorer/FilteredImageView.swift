//
//  FilteredImageView.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/8/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import CoreImage

class FilteredImageView: UIImageView, ParameterAdjustmentDelegate {
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    var renderingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
    var ciContext: CIContext!
    var filter: CIFilter! {
        didSet {
            self.updateFilteredImage()
        }
    }
    var inputImage: UIImage! {
        didSet {
            self.updateFilteredImage()
        }
    }

    init(frame: CGRect, context: CIContext) {
        super.init(frame: frame)
        self.ciContext = context
        self.clipsToBounds = true

        self.spinner.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(self.spinner)

        self.addConstraint(NSLayoutConstraint(item: self.spinner, attribute: .CenterX, relatedBy: .Equal,
                                              toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.spinner, attribute: .CenterY, relatedBy: .Equal,
                                              toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateFilteredImage() {
        if self.image == nil {
            self.image = self.inputImage
        }

        if self.inputImage != nil && self.filter != nil {
            self.spinner.startAnimating()

            let inputCIImage = CIImage(image: self.inputImage)
            self.filter.setValue(inputCIImage, forKey: kCIInputImageKey)

            dispatch_async(renderingQueue, { () -> Void in
                let cropRect = inputCIImage.extent()

                if let outputImage = self.filter.outputImage {
                    let cgImage = self.ciContext.createCGImage(outputImage, fromRect: cropRect)

                    let displayImage = UIImage(CGImage: cgImage)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.image = displayImage
                        self.spinner.stopAnimating()
                    })
                }
            })
        }
    }

    func parameterValueDidChange(parameter: ScalarFilterParameter) {
        self.filter.setValue(parameter.currentValue, forKey: parameter.key)
        self.updateFilteredImage()
    }
}
