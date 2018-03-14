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

    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "TouristSiteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TouristSiteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func fetchTouristSites() {
        touristSiteProvider?.getTouristSites { (touristSites, error) in
            
            if let error = error {
                print("[ViewController] Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                if let touristSites = touristSites {
                    self.touristSites = touristSites
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
        cell.configure(touristSite: touristSites[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
}

// MARK: - UITableViewDelegate
extension TouristSitesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        detailVC.touristSite = touristSites[indexPath.section]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
