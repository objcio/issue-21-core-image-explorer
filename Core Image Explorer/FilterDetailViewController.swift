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

        navigationItem.title = filter.attributes[kCIAttributeFilterDisplayName] as? String

        addSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
        navigationController?.navigationBar.barStyle = .black
        tabBarController?.tabBar.barStyle = .black

        applyConstraintsForInterfaceOrientation(UIApplication.shared.statusBarOrientation)
    }

    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval)
    {
        applyConstraintsForInterfaceOrientation(toInterfaceOrientation)
    }

    func filterParameterDescriptors() -> [ScalarFilterParameter] {
        let inputNames = (filter.inputKeys as [String]).filter { (parameterName) -> Bool in
            return (parameterName as String) != "inputImage"
        }

        let attributes = filter.attributes

        return inputNames.compactMap { (inputName: String) -> ScalarFilterParameter? in
            let attribute = attributes[inputName] as! [String : AnyObject]
            guard attribute[kCIAttributeSliderMin] != nil else { return nil }
            // strip "input" from the start of the parameter name to make it more presentation-friendly
            let displayName = String(inputName.dropFirst(5))

            let minValue = (attribute[kCIAttributeSliderMin] as! NSNumber).floatValue
            let maxValue = (attribute[kCIAttributeSliderMax] as! NSNumber).floatValue
            let defaultValue = (attribute[kCIAttributeDefault] as! NSNumber).floatValue

            return ScalarFilterParameter(name: displayName, key: inputName,
                                         minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue)
        }
    }

    func addSubviews() {
        filteredImageView = FilteredImageView(frame: view.bounds)
        filteredImageView.inputImage = UIImage(named: kSampleImageName)
        filteredImageView.filter = filter
        filteredImageView.contentMode = .scaleAspectFit
        filteredImageView.clipsToBounds = true
        filteredImageView.backgroundColor = view.backgroundColor
        filteredImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filteredImageView)

        parameterAdjustmentView = ParameterAdjustmentView(frame: view.bounds, parameters: filterParameterDescriptors())
        parameterAdjustmentView.translatesAutoresizingMaskIntoConstraints = false
        parameterAdjustmentView.setAdjustmentDelegate(filteredImageView)
        view.addSubview(parameterAdjustmentView)
    }

    func applyConstraintsForInterfaceOrientation(_ interfaceOrientation: UIInterfaceOrientation) {
        view.removeConstraints(constraints)
        constraints.removeAll(keepingCapacity: true)

        if interfaceOrientation.isLandscape {
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 1, constant: -66))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .top, relatedBy: .equal,
                toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .leading, relatedBy: .equal,
                toItem: view, attribute: .leading, multiplier: 1, constant: 0))

            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .top, relatedBy: .equal,
                toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .trailing, relatedBy: .equal,
                toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 1, constant: 0))
        } else {
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 0.5, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .top, relatedBy: .equal,
                toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: filteredImageView, attribute: .leading, relatedBy: .equal,
                toItem: view, attribute: .leading, multiplier: 1, constant: 0))

            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .bottom, relatedBy: .equal,
                toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .leading, relatedBy: .equal,
                toItem: view, attribute: .leading, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .width, relatedBy: .equal,
                toItem: view, attribute: .width, multiplier: 1, constant: 0))
            constraints.append(NSLayoutConstraint(item: parameterAdjustmentView, attribute: .height, relatedBy: .equal,
                toItem: view, attribute: .height, multiplier: 0.5, constant: -88))
        }

        self.view.addConstraints(constraints)
    }
}
