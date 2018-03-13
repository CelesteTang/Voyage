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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TouristSiteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TouristSiteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension TouristSitesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouristSiteTableViewCell") as! TouristSiteTableViewCell
        cell.configure()
        return cell
    }
}

extension TouristSitesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let DetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
}
