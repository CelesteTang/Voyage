//
//  DetailVC.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imagePageView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var touristSite: TouristSite!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pageVC = storyboard?.instantiateViewController(withIdentifier: "ImagePageVC") as! ImagePageVC
        pageVC.touristSite = touristSite
        imagePageView.addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: imagePageView.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: imagePageView.leadingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: imagePageView.bottomAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: imagePageView.trailingAnchor)
        ])
    }

}
