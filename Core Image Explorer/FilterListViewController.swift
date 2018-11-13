//
//  FilterListViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class FilterListViewController: UITableViewController {
    let categorizedFilters: [(categoryName: String, filterNames:[String])] = [
        ("Distortion Effect", [
            ("CIDroste"),
            ("CIGlassLozenge"),
            ("CIHoleDistortion"),
            ("CILightTunnel"),
            ("CIPinchDistortion"),
            ("CITorusLensDistortion"),
            ("CITwirlDistortion"),
            ("CIVortexDistortion"),
            ]),
        ("Geometry Adjustment", [
            ("CILanczosScaleTransform"),
            ("CIStraightenFilter"),
            ]),
        ("Halftone Effect", [
            ("CICircularScreen"),
            ("CICMYKHalftone"),
            ("CIDotScreen"),
            ("CIHatchedScreen"),
            ("CILineScreen"),
            ]),
        ("Color Effect", [
            ("CIColorInvert"),
            ("CIColorMonochrome"),
            ("CIColorPosterize"),
            ("CIDither"),
            ("CIFalseColor"),
            ("CIMaximumComponent"),
            ("CIMinimumComponent"),
            ("CISepiaTone"),
            ("CIThermal"),
            ("CIVignette"),
            ("CIVignetteEffect"),
            ("CIXRay"),
            ]),
        ("Color Adjustment", [
            ("CIColorControls"),
            ("CIExposureAdjust"),
            ("CIGammaAdjust"),
            ("CIHueAdjust"),
            ("CILinearToSRGBToneCurve"),
            ("CISRGBToneCurveToLinear"),
            ("CIVibrance"),
            ]),
        ("Tile Effect", [
            ("CIGlideReflectedTile"),
            ("CIKaleidoscope"),
            ("CIOpTile"),
            ("CIParallelogramTile"),
            ("CIPerspectiveTile"),
            ("CISixfoldReflectedTile"),
            ("CISixfoldRotatedTile"),
            ("CITriangleKaleidoscope"),
            ("CITriangleTile"),
            ("CITwelvefoldReflectedTile"),
            ]),
        ("Stylize", [
            ("CIBloom"),
            ("CIComicEffect"),
            ("CICrystallize"),
            ("CIDepthOfField"),
            ("CIEdges"),
            ("CIEdgeWork"),
            ("CIGloom"),
            ("CIHeightFieldFromMask"),
            ("CIHexagonalPixellate"),
            ("CIHighlightShadowAdjust"),
            ("CIPixellate"),
            ("CIPointillize"),
            ("CISpotColor"),
            ("CISpotLight"),
            ]),
        ("Blur", [
            ("CIBokehBlur"),
            ("CIBoxBlur"),
            ("CIDiscBlur"),
            ("CIGaussianBlur"),
            ("CIMedianFilter"),
            ("CIMorphologyGradient"),
            ("CIMorphologyMaximum"),
            ("CIMorphologyMinimum"),
            ("CIMotionBlur"),
            ("CINoiseReduction"),
            ("CIZoomBlur"),
            ])
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
                controller.filterName = categorizedFilters[indexPath.section].filterNames[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categorizedFilters.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categorizedFilters[section].categoryName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorizedFilters[section].filterNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterName = categorizedFilters[indexPath.section].filterNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SystemFilterCell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = CIFilter(name: filterName)!.attributes[kCIAttributeFilterDisplayName] as? String

        return cell
    }
}

