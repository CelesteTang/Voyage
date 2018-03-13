//
//  TouristSite.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

struct TouristSite: Codable {
    
    let title: String
    let description: String
    let images: String
    let address: String
    let info: String
    
    enum CodingKeys: String, CodingKey {
        case title = "stitle"
        case description = "xbody"
        case images = "file"
        case address
        case info
    }
}
