//
//  TouristSitesVC.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

class TouristSitesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var touristSites: [TouristSite] = []
    
    private var touristSiteProvider: TouristSiteProvider? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        touristSiteProvider = TouristSiteProvider()
        fetchTouristSites()
        
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "TouristSiteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TouristSiteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configureNavigationBar() {
        navigationItem.title = "台北市熱門景點"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = Palette.blue
        navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func fetchTouristSites() {
        touristSiteProvider?.getTouristSites { (touristSites, error) in
            
            if let error = error {
                print("[ViewController] Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                if let touristSites = touristSites {
                    self.touristSites.append(contentsOf: touristSites)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TouristSitesVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return touristSites.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouristSiteTableViewCell") as! TouristSiteTableViewCell
        cell.delegate = self
        cell.configure(touristSite: touristSites[indexPath.section])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TouristSitesVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        detailVC.touristSite = touristSites[indexPath.section]
        let cell = tableView.cellForRow(at: indexPath) as! TouristSiteTableViewCell
        detailVC.images = cell.images
        detailVC.showSingleImage = false
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            self.fetchTouristSites()
        }
    }
}

// MARK: - TouristSiteTableViewCellDelegate
extension TouristSitesVC: TouristSiteTableViewCellDelegate {
    
    func touristSiteTableViewCell(_ cell: TouristSiteTableViewCell, didSelect imageCell: ImageCollectionViewCell, image: UIImage) {
        
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        detailVC.touristSite = cell.touristSite
        detailVC.images = [image]
        detailVC.showSingleImage = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
