//
//  PhotosCollectionFilter.swift
//  Navigation
//
//  Created by Sokolov on 01.12.2022.
//

import UIKit
import iOSIntPackage

final class PhotoCollectionFilter {

    private let imageProcessor = ImageProcessor()
    var finalImagesArray: [UIImage] = []

    func createArrayOfImages(arrayOf: [UIImage]) -> [UIImage] {
        for i in 1...Photos.shared.examples.endIndex{
            var finishedImage = UIImage()
            imageProcessor.processImage(sourceImage: arrayOf[i], filter: .noir) { finishedImage = $0 ?? UIImage(named: "p\(i)" )! }
            finalImagesArray.append(finishedImage)
        }
        return finalImagesArray
    }
}
