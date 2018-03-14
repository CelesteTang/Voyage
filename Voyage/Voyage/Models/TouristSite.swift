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
    
    var imageURLs: [String] {
        return file.toURLArray()
    }
    
    lazy var images: [UIImage] = {
        
        var images = [UIImage]()
        
        self.imageURLs.forEach {
            
            guard let url = URL(string: $0) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                images.append(image)
                
            } catch {
                
                print(error.localizedDescription)
                
            }
        }
        
        return images
    }()
}
