//
//  TouristSiteTableViewCell.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

protocol TouristSiteTableViewCellDelegate: class {
    func touristSiteTableViewCell(_ cell: TouristSiteTableViewCell, didSelect imageCell: ImageCollectionViewCell, image: UIImage)
}

class TouristSiteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var touristSite: TouristSite!
    var images = [UIImage]()
    
    weak var delegate: TouristSiteTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
        configureLabel()
    }
    
    private func configureCollectionView() {
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self

        let layout = imagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 200, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
    }
    
    private func configureLabel() {
        titleLabel?.textColor = UIColor.gray
        descriptionLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func configure(touristSite: TouristSite) {
        self.touristSite = touristSite
        
        titleLabel.text = touristSite.title
        descriptionLabel.text = touristSite.description
        
        images = []
        
        touristSite.imageURLs.forEach { url in
            
            if let image = url.cachedImage(touristSite: touristSite.title) {
                self.images.append(image)
                self.imagesCollectionView.reloadData()
            } else {
                url.fetchImage(of: touristSite.title) { image in
                    self.images.append(image)
                    self.imagesCollectionView.reloadData()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TouristSiteTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.configure(image: images[indexPath.item])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension TouristSiteTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else {
            print("ERROR")
            return
        }
        
        delegate?.touristSiteTableViewCell(self, didSelect: cell, image: images[indexPath.item])
    }
}
