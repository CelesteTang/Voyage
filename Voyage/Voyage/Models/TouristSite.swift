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
    let file: String
    let address: String
    let info: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "stitle"
        case description = "xbody"
        case file = "file"
        case address = "address"
        case info = "info"
    }
    
    var imageURLs: [URL] {
        return file.toURLArray()
    }
//    
//    lazy var images: [UIImage] = {
//        
//        var images = [UIImage]()
//        
//        imageURLs.forEach { url in
//            
//            if let image = url.cachedImage(touristSite: self.title) {
//                images.append(image)
//            } else {
//                url.fetchImage(of: self.title) { image in
//                    images.append(image)
//                }
//            }
//        }
//        
//        return images
//    }()
}
