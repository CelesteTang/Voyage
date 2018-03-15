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
    
    var noData: Bool {
        return touristSites.count == 0
    }
    
    var isNetworkConnected: Bool {
        return ReachabilityMonitor.shared.isNetworkAvailable
    }
    
    private var touristSiteProvider: TouristSiteProvider? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        touristSiteProvider = TouristSiteProvider()
        fetchTouristSites()
        
        configureTableView()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ReachabilityMonitor.shared.startMonitoring { [unowned self] (isNetworkConnected) in
            if isNetworkConnected && self.noData {
                self.fetchTouristSites()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ReachabilityMonitor.shared.stopMonitoring()
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
        if isNetworkConnected {
            touristSiteProvider?.getTouristSites { [unowned self] (touristSites, error) in
                
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
        } else {
            showNoNetworkAlert()
        }
    }
    
    private func showNoNetworkAlert() {
        let alert = UIAlertController(title: "Warning",
                                      message: "There is no network connection right now. Please try again later.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
        
        let cell = tableView.cellForRow(at: indexPath) as! TouristSiteTableViewCell
        showDetailVC(of: touristSites[indexPath.section], withImages: cell.images)

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
    
    fileprivate func showDetailVC(of touristSite: TouristSite, withImages images: [UIImage]) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        detailVC.touristSite = touristSite
        detailVC.images = images
        detailVC.showSingleImage = images.count == 1 ? true : false
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TouristSiteTableViewCellDelegate
extension TouristSitesVC: TouristSiteTableViewCellDelegate {
    
    func touristSiteTableViewCell(_ cell: TouristSiteTableViewCell, didSelect imageCell: ImageCollectionViewCell, image: UIImage) {
        
        showDetailVC(of: cell.touristSite, withImages: [image])
    }    
}
