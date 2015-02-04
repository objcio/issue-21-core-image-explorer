//
//  FilterDetailViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var filterName: String!
    var filter: CIFilter!
    var filteredImageView: FilteredImageView!
    var parameterAdjustmentView: ParameterAdjustmentView!
    var constraints = [NSLayoutConstraint]()

    override func viewDidLoad() {
        super.viewDidLoad()

        filter = CIFilter(name: filterName)

        navigationItem.title = filter.attributes()![kCIAttributeFilterDisplayName] as? NSString

        addSubviews()
    }

    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: animated)
        navigationController?.navigationBar.barStyle = .Black
        tabBarController?.tabBar.barStyle = .Black

        applyConstraintsForInterfaceOrientation(UIApplication.sharedApplication().statusBarOrientation)
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval)
    {
        applyConstraintsForInterfaceOrientation(toInterfaceOrientation)
    }

    func filterParameterDescriptors() -> [ScalarFilterParameter] {
        var inputNames = (filter.inputKeys() as [String]).filter { (parameterName) -> Bool in
            return (parameterName as String) != "inputImage"
        }

        let attributes = filter.attributes()!

        return inputNames.map { (inputName: String) -> ScalarFilterParameter in
            let attribute = attributes[inputName] as [String : AnyObject]
            // strip "input" from the start of the parameter name to make it more presentation-friendly
            let displayName = inputName[advance(inputName.startIndex, 5)..<inputName.endIndex]
            let minValue = attribute[kCIAttributeSliderMin] as Float
            let maxValue = attribute[kCIAttributeSliderMax] as Float
            let defaultValue = attribute[kCIAttributeDefault] as Float

            return ScalarFilterParameter(name: displayName, key: inputName,
                                         minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue)
        }
    }

    func addSubviews() {
        filteredImageView = FilteredImageView(frame: view.bounds)
        filteredImageView.inputImage = UIImage(named: kSampleImageName)
        filteredImageView.filter = filter
        filteredImageView.contentMode = .ScaleAspectFit
        filteredImageView.clipsToBounds = true
        filteredImageView.backgroundColor = view.backgroundColor
        filteredImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(filteredImageView)

        parameterAdjustmentView = ParameterAdjustmentView(frame: view.bounds, parameters: filterParameterDescriptors())
        parameterAdjustmentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        parameterAdjustmentView.setAdjustmentDelegate(filteredImageView)
        view.addSubview(parameterAdjustmentView)
    }

    func applyConstraintsForInterfaceOrientation(interfaceOrientation: UIInterfaceOrientation) {
        view.removeConstraints(constraints)
        constraints.removeAll(keepCapacity: true)

        if UIInterfaceOrientationIsLandscape(interfaceOrientation) {
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Width, relatedBy: .Equal,
                toItem: view, attribute: .Width, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Height, relatedBy: .Equal,
                toItem: view, attribute: .Height, multiplier: 1, constant: -66))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Top, relatedBy: .Equal,
                toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Leading, relatedBy: .Equal,
                toItem: view, attribute: .Leading, multiplier: 1, constant: 0))

            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Top, relatedBy: .Equal,
                toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Trailing, relatedBy: .Equal,
                toItem: view, attribute: .Trailing, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Width, relatedBy: .Equal,
                toItem: view, attribute: .Width, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Height, relatedBy: .Equal,
                toItem: view, attribute: .Height, multiplier: 1, constant: 0))
        } else {
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Width, relatedBy: .Equal,
                toItem: view, attribute: .Width, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Height, relatedBy: .Equal,
                toItem: view, attribute: .Height, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Top, relatedBy: .Equal,
                toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .Leading, relatedBy: .Equal,
                toItem: view, attribute: .Leading, multiplier: 1, constant: 0))

            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Bottom, relatedBy: .Equal,
                toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Leading, relatedBy: .Equal,
                toItem: view, attribute: .Leading, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Width, relatedBy: .Equal,
                toItem: view, attribute: .Width, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .Height, relatedBy: .Equal,
                toItem: view, attribute: .Height, multiplier: 0.5, constant: -88))
        }

        self.view.addConstraints(constraints)
    }
}
