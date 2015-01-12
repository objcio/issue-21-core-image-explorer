//
//  FilterDetailViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit
import Photos

class FilterDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var detailDescriptionView: UITextView!
    weak var filteredImageView: FilteredImageView!

    var ciContext: CIContext!
    var filterName: String!
    var filter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.filter = CIFilter(name: self.filterName)
        let attributes = self.filter.attributes()!
        let displayName = attributes[kCIAttributeFilterDisplayName] as? NSString
        self.navigationItem.title = displayName

        var filteredImageView = FilteredImageView(frame: self.view.bounds, context: self.ciContext)
        filteredImageView.inputImage = UIImage(named: "duckling.jpg")
        filteredImageView.filter = filter
        filteredImageView.contentMode = .ScaleAspectFit
        filteredImageView.clipsToBounds = true
        filteredImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(filteredImageView)
        self.filteredImageView = filteredImageView

        self.view.addConstraint(NSLayoutConstraint(item: self.filteredImageView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.filteredImageView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.filteredImageView, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.filteredImageView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0))

        var inputNames = (self.filter.inputKeys() as [String]).filter { (parameterName) -> Bool in
            return (parameterName as String) != "inputImage"
        }

        var scalarAttributeDescriptions = [ScalarFilterParameter]()
        for inputName: String in inputNames {
            let attribute = attributes[inputName] as [String : AnyObject]
            let displayName = inputName[advance(inputName.startIndex, 5)..<inputName.endIndex]
            let minValue = attribute[kCIAttributeSliderMin] as Float
            let maxValue = attribute[kCIAttributeSliderMax] as Float
            let defaultValue = attribute[kCIAttributeDefault] as Float

            scalarAttributeDescriptions.append(ScalarFilterParameter(name: displayName, key: inputName, minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue))
        }

        var paramAdjView = ParameterAdjustmentView(frame: self.view.bounds, parameters: scalarAttributeDescriptions)
        paramAdjView.setTranslatesAutoresizingMaskIntoConstraints(false)
        paramAdjView.setAdjustmentDelegate(self.filteredImageView)
        self.view.addSubview(paramAdjView)

        self.view.addConstraint(NSLayoutConstraint(item: paramAdjView, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: paramAdjView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: paramAdjView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: paramAdjView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.5, constant: 0))

        var selectButton = UIBarButtonItem(title: "Select Photo", style: UIBarButtonItemStyle.Bordered, target: self, action: "displayPhotoPicker")
        self.navigationItem.rightBarButtonItem = selectButton
    }

    func loadPhoto(url: NSURL) {
        let assets = PHAsset.fetchAssetsWithALAssetURLs([url], options: nil) as PHFetchResult
        let photoAsset = assets.firstObject as PHAsset

        let photoManager = PHImageManager.defaultManager()

        let options = PHImageRequestOptions()
        options.deliveryMode = .Opportunistic

        let viewSize = self.view.bounds.size
        let maxSize = max(viewSize.width, viewSize.height)
        let size = CGSizeMake(maxSize, maxSize)

        photoManager.requestImageForAsset(photoAsset, targetSize: size, contentMode: .AspectFit, options: options) { (image, info) -> Void in
            self.filteredImageView.inputImage = image
        }
    }

    func displayPhotoPicker() {
        var pickerController = UIImagePickerController()
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.delegate = self

        self.presentViewController(pickerController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let photoURL = info[UIImagePickerControllerReferenceURL] as NSURL!
        self.loadPhoto(photoURL)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
