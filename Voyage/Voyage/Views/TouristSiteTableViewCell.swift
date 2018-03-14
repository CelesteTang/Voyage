//
//  TouristSiteTableViewCell.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class TouristSiteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    private var touristSite: TouristSite!
    private var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        imagesCollectionView.dataSource = self
        
        let layout = self.imagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 200, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
    }
    
    func configure(touristSite: TouristSite) {
        self.touristSite = touristSite
        
        titleLabel.text = touristSite.title
        descriptionLabel.text = touristSite.description
        
        touristSite.imageURLs.forEach { url in
            
            DispatchQueue.global().async {
                
                do {
                    guard let url = URL(string: url) else {
                        return
                    }
                    
                    let data = try Data(contentsOf: url)
                    
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.images.append(image)
                        self.imagesCollectionView.reloadData()
                    }
                    
                } catch {
                    
                    print(error.localizedDescription)
                    
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
