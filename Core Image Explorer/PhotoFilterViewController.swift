//
//  PhotoFilterViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/12/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class PhotoFilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var filteredImageView: FilteredImageView!
    @IBOutlet weak var photoFilterCollectionView: UICollectionView!

    var filters = [CIFilter]()

    let filterDescriptors: [(filterName: String, filterDisplayName: String)] = [
        ("CIColorControls", "None"),
        ("CIPhotoEffectMono", "Mono"),
        ("CIPhotoEffectTonal", "Tonal"),
        ("CIPhotoEffectNoir", "Noir"),
        ("CIPhotoEffectFade", "Fade"),
        ("CIPhotoEffectChrome", "Chrome"),
        ("CIPhotoEffectProcess", "Process"),
        ("CIPhotoEffectTransfer", "Transfer"),
        ("CIPhotoEffectInstant", "Instant"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        for descriptor in filterDescriptors {
            filters.append(CIFilter(name: descriptor.filterName)!)
        }

        filteredImageView.inputImage = UIImage(named: kSampleImageName)
        filteredImageView.contentMode = .scaleAspectFit
        filteredImageView.filter = filters[0]
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: animated)
        navigationController?.navigationBar.barStyle = .black
        tabBarController?.tabBar.barStyle = .black
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDescriptors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFilterCell", for: indexPath) as! PhotoFilterCollectionViewCell
        cell.filteredImageView.contentMode = .scaleAspectFill
        cell.filteredImageView.inputImage = filteredImageView.inputImage
        cell.filteredImageView.filter = filters[indexPath.item]
        cell.filterNameLabel.text = filterDescriptors[indexPath.item].filterDisplayName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filteredImageView.filter = filters[indexPath.item]
    }
}
