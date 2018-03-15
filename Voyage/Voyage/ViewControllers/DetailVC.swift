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
    var images = [UIImage]()
    var showSingleImage = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        
        if showSingleImage {
            configureImage()
        } else {
            configurePageView()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = touristSite.title
    }
    
    private func configurePageView() {
        let pageVC = storyboard?.instantiateViewController(withIdentifier: "ImagePageVC") as! ImagePageVC
        pageVC.touristSite = touristSite
        pageVC.images = images
        
        imagePageView.addSubview(pageVC.view)
        
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: imagePageView.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: imagePageView.leadingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: imagePageView.bottomAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: imagePageView.trailingAnchor)
        ])
        
        addChildViewController(pageVC)
    }
    
    private func configureImage() {
        
        let imageView = UIImageView(image: images.first)
        imagePageView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imagePageView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imagePageView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: imagePageView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: imagePageView.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension DetailVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        configureCell(cell, at: indexPath)
        return cell
    }

    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let titles = ["景點名稱", "景點介紹", "地址", "資訊"]
        let contents = [touristSite.title, touristSite.description, touristSite.address, touristSite.info]
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = contents[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.textColor = UIColor.gray
    }
}

// MARK: - UITableViewDelegate
extension DetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
}
