//
//  ImagePageVC.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/14.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class ImagePageVC: UIPageViewController {

    var touristSite: TouristSite!
    var images = [UIImage]()
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let startingViewController = contentViewController(at: 0) {
            
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            
        }
    }
    
    func contentViewController(at index: Int) -> ImageVC? {
        
        if index < 0 || index >= images.count {
            return nil
        }
        
        guard let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageVC else {
            return nil
        }
        imageVC.images = images
        imageVC.index = index
        
        return imageVC
    }
}

extension ImagePageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // swiftlint:disable force_cast
        var index = (viewController as! ImageVC).index
        // swiftlint:enable force_cast
        index += 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // swiftlint:disable force_cast
        var index = (viewController as! ImageVC).index
        // swiftlint:enable force_cast
        index -= 1
        
        return contentViewController(at: index)
    }
    
}

