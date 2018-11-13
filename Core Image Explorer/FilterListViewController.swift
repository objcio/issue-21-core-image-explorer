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

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.default, animated: animated)
        navigationController?.navigationBar.barStyle = .default
        tabBarController?.tabBar.barStyle = .default
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! FilterDetailViewController
                controller.filterName = filters[indexPath.row].filterName
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterProperties: (filterName: String, filterDisplayName: String) = filters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SystemFilterCell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = filterProperties.filterDisplayName;
        return cell
    }
}

