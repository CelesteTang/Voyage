//
//  ImageCache.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/15.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class ImageCache: NSCache<AnyObject, AnyObject> {
    
    var touristSite: String
    
    init(touristSite: String) {
        self.touristSite = touristSite
        super.init()
        self.name = touristSite
        self.countLimit = 20 // Max 20 images in memory.
        self.totalCostLimit = 10*1024*1024 // Max 10MB used.
    }
}

extension URL {
    
    func cachedImage(touristSite: String) -> UIImage? {
        return ImageCache(touristSite: touristSite).object(forKey: absoluteString as AnyObject) as? UIImage
    }
    
    func fetchImage(of touristSite: String, completion: @escaping (UIImage) -> Void) {
        // 如果需要客製化取得資料在此做
        let task = URLSession.shared.dataTask(with: self) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                ImageCache(touristSite: touristSite).setObject(image, forKey: self.absoluteString as AnyObject, cost: data.count)
                
                DispatchQueue.main.async() {
                    completion(image)
                }
            }
        }
        task.resume()
    }
    
}
