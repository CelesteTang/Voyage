//
//  ImageVC.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/14.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index = 0
    var heading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageControl.currentPage = index

    }

}
