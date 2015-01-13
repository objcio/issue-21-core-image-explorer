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

    var spinner: UIActivityIndicatorView!

    var renderingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)

    var ciContext: CIContext!

    var filter: CIFilter! {
        didSet {
            updateFilteredImage()
        }
    }

    var inputImage: UIImage! {
        didSet {
            updateFilteredImage()
        }
    }

    init(frame: CGRect, context: CIContext?) {
        super.init(frame: frame)
        ciContext = context
        clipsToBounds = true
        addSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        addSubviews()
    }

    func addSubviews() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        spinner.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(spinner)

        addConstraint(NSLayoutConstraint(item: spinner, attribute: .CenterX, relatedBy: .Equal,
                                         toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: spinner, attribute: .CenterY, relatedBy: .Equal,
                                         toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    }

    func updateFilteredImage() {
        if image == nil {
            image = inputImage
        }

        if inputImage != nil && filter != nil {
            spinner.startAnimating()

            let inputCIImage = CIImage(image: inputImage)
            filter.setValue(inputCIImage, forKey: kCIInputImageKey)

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
        filter.setValue(parameter.currentValue, forKey: parameter.key)
        updateFilteredImage()
    }
}
