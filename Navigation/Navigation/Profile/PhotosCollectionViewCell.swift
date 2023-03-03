//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Sokolov on 21.10.2022.
//

import UIKit
import iOSIntPackage

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static var background: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
                } else {
                    return UIColor.white
                    
                }
            }
        } else {
            return UIColor.white
        }
    }()
    
    var photos = [UIImage]()
    
    let imageFacade = ImagePublisherFacade()
    
    private lazy var collectionImage: UIImageView = {
        let collectionImage = UIImageView ()
        //        collectionImage.contentMode = .scaleAspectFit
        collectionImage.clipsToBounds = true
        collectionImage.translatesAutoresizingMaskIntoConstraints = false
        return collectionImage
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionImage)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellCollection(photo: UIImage) {
        self.collectionImage.image = photo
    }
    
//    func setupCell(for imageName:String, or indexPath: IndexPath, arrayOfImages: [UIImage]) {
//        let arrayOfFinishedImages: [UIImage] = PhotoCollectionFilter().createArrayOfImages(arrayOf: arrayOfImages)
//            collectionImage.image = arrayOfFinishedImages[indexPath.row]
//        }
    
    private func setupView() {
        self.contentView.addSubview(self.collectionImage)
        self.contentView.backgroundColor = PhotosCollectionViewCell.background
        
        NSLayoutConstraint.activate([
            self.collectionImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collectionImage.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }
    
    
}

