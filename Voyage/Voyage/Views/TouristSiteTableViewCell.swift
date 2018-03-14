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

    func configure(touristSite: TouristSite) {
        titleLabel.text = touristSite.title
        descriptionLabel.text = touristSite.description
    }
}
