//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Sokolov on 20.10.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
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
    
    private lazy var imageFacade = ImagePublisherFacade()
    //    private lazy var arrayOfImagesForObserver = [UIImage]()
    lazy var arrayOfImages = [UIImage]()
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func arrayFilling() throws -> [UIImage] {
        Photos.shared.examples.forEach { photo in
            self.arrayOfImages.append(photo)
        }
       
      if Photos.shared.examples.count == 0 {
          throw NetworkError.NetwrokError200
       } else if arrayOfImages.count == 0 {
           throw DataBaseError.incorrectReceivedData
        } else {
            return arrayOfImages
        }
    }
    
    private func setupArray() {
        
        do {
          arrayOfImages = try arrayFilling()
        } catch DataBaseError.incorrectData {
            print("Error: incrorrectData")
            let alert = UIAlertController(title: "Photos not added yet", message: "Please, add photos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Add photos", style: .default))
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            self.present(alert, animated: true)
        } catch NetworkError.NetwrokError200 {
            print("Error: wrongConnection")
            let alert = UIAlertController(title: "No connection to server", message: "Please, reload the page", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            self.present(alert, animated: true)
        } catch {
            print("Unknow error")
        }
        
        let imageProcessor = ImageProcessor()
        
        let startUpdatePhotos = DispatchTime.now()
        
        imageProcessor.processImagesOnThread(sourceImages: arrayOfImages, filter: .chrome, qos: .utility) { [weak self] image in DispatchQueue.main.async {
            self?.arrayOfImages = image.map({ image in
                UIImage(cgImage: image!) })
            
            self?.collectionView.reloadData()
            
            }
            
            let endUpdatePhotos = DispatchTime.now()
            
            let nanoTime = endUpdatePhotos.uptimeNanoseconds - startUpdatePhotos.uptimeNanoseconds
            
            let timeInterval = Double(nanoTime) / 1_000_000_000
            
            print("Интервал загрузки \(timeInterval) секунд")
            
        }
    }

    
//filter: .colorInvert, qos: .userInitiated Интервал загрузки 1.087174542 секунд
//filter: .noir, qos: .userInteractive Интервал загрузки 1.07598075 секунд
//filter: .colorInvert, qos: .utility Интервал загрузки 1.127721792 секунд
    
//        imageFacade.addImagesWithTimer(time: 1, repeat: 21, userImages: arrayOfImagesForObserver)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("photo_gallerey", comment: "")
        self.navigationController?.navigationBar.backgroundColor = PhotosViewController.background
        self.view.backgroundColor = PhotosViewController.background
        self.setupView()
        self.setupArray()
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        imageFacade.removeSubscription(for: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        imageFacade.subscribe(self)
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! PhotosCollectionViewCell
    
    cell.backgroundColor = .gray
    cell.clipsToBounds = true
    cell.configCellCollection(photo: arrayOfImages[indexPath.item])
    
    return cell
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWidth = floor(width / Constants.numberOfItemsInLine)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {

    func receive(images: [UIImage]) {
        arrayOfImages = images
        collectionView.reloadData()
    }
}
    
    



