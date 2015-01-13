//
//  FilterListViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class FilterListViewController: UITableViewController {
    let filters: [(filterName: String, filterDisplayName: String)] = [
        ("CIBloom", "Bloom"),
        ("CIColorControls", "Color Controls"),
        ("CIColorInvert", "Color Invert"),
        ("CIColorPosterize", "Color Posterize"),
        ("CIExposureAdjust", "Exposure Adjust"),
        ("CIGammaAdjust", "Gamma Adjust"),
        ("CIGaussianBlur", "Gaussian Blur"),
        ("CIGloom", "Gloom"),
        ("CIHighlightShadowAdjust", "Highlights and Shadows"),
        ("CIHueAdjust", "Hue Adjust"),
        ("CILanczosScaleTransform", "Lanczos Scale Transform"),
        ("CIMaximumComponent", "Maximum Component"),
        ("CIMinimumComponent", "Minimum Component"),
        ("CISepiaTone", "Sepia Tone"),
        ("CISharpenLuminance", "Sharpen Luminance"),
        ("CIStraightenFilter", "Straighten"),
        ("CIUnsharpMask", "Unsharp Mask"),
        ("CIVibrance", "Vibrance"),
        ("CIVignette", "Vignette")
    ]

    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: animated)
        navigationController?.navigationBar.barStyle = .Default
        tabBarController?.tabBar.barStyle = .Default
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                var controller = segue.destinationViewController as FilterDetailViewController
                controller.filterName = filters[indexPath.row].filterName
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let filterProperties: (filterName: String, filterDisplayName: String) = filters[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SystemFilterCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = filterProperties.filterDisplayName;
        return cell
    }
}

