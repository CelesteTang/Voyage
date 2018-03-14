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
            
            if let touristSites = touristSites {
                self.touristSites = touristSites
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TouristSitesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touristSites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouristSiteTableViewCell") as! TouristSiteTableViewCell
        cell.configure()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TouristSitesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let DetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
}
