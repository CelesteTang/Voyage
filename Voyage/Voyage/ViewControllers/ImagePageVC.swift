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
    private var images = [UIImage]()

    var pageContentViewController: ImageVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let startingViewController = contentViewController(at: 0) {
            
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            
        }
        
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
                        self.pageContentViewController.imageView.image = self.images[self.pageContentViewController.index]
                    }
                    
                } catch {
                    
                    print(error.localizedDescription)
                    
                }
            }
            
        }
    }
    
    func contentViewController(at index: Int) -> ImageVC? {
        
        if index < 0 || index >= touristSite.imageURLs.count {
            return nil
        }
        
        pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageVC
        pageContentViewController.index = index
        
        return pageContentViewController
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
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

