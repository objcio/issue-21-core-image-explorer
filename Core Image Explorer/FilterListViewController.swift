//
//  FilterListViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class FilterListViewController: UITableViewController {

    let ciContext = CIContext(options: nil)

    var detailViewController: FilterDetailViewController? = nil

    let filters: [(String, String)] = [
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
//        ("CIPhotoEffectChrome", "Photo Effect Chrome"),
//        ("CIPhotoEffectFade", "Photo Effect Fade"),
//        ("CIPhotoEffectInstant", "Photo Effect Instant"),
//        ("CIPhotoEffectMono", "Photo Effect Mono"),
//        ("CIPhotoEffectNoir", "Photo Effect Noir"),
//        ("CIPhotoEffectProcess", "Photo Effect Process"),
//        ("CIPhotoEffectTonal", "Photo Effect Tonal"),
//        ("CIPhotoEffectTransfer", "Photo Effect Transfer"),
        ("CISepiaTone", "Sepia Tone"),
        ("CISharpenLuminance", "Sharpen Luminance"),
        ("CIStraightenFilter", "Straighten"),
        ("CIUnsharpMask", "Unsharp Mask"),
        ("CIVibrance", "Vibrance"),
        ("CIVignette", "Vignette")
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Core Image Filters"

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? FilterDetailViewController
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let filterProperties: (filterName: String, filterDisplayName: String) = filters[indexPath.row]
                let controller = (segue.destinationViewController as UINavigationController).topViewController as FilterDetailViewController
                controller.ciContext = self.ciContext
                controller.filterName = filterProperties.filterName
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = filterProperties.filterDisplayName;
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
}

