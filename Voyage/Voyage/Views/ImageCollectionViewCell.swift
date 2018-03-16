//
//  ImageCollectionViewCell.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/14.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.image = #imageLiteral(resourceName: "imagePlaceholder")
    }

    func configure(image: UIImage) {
        imageView.image = image
    }
    
}
