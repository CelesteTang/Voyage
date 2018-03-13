//
//  TouristSitesVC.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import UIKit

enum GeneralError: Error {
    
    case formURLFail
}

class TouristSitesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataLoader: DataLoader? = nil
    private var requestToken: RequestToken? = nil
    
    var touristSites: [TouristSite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataLoader = DataLoader()

        self.getData { (touristSites, error) in
            
            if let error = error {
                print("[ViewController] Error: \(error.localizedDescription)")
            }
            
            if let touristSites = touristSites {
                self.touristSites = touristSites
            }
        }
        
        configureTableView()
    }
    
    private func getData(completionHandler: @escaping ([TouristSite]?, Error?) -> Swift.Void) {
        
        requestToken?.cancel()
        
        guard let url = URL(string: Config.url) else {
            completionHandler(nil, GeneralError.formURLFail)
            return
        }
        
        requestToken = dataLoader?.getData(url: url, completionHandler: { result in
            
            switch result {
                
            case .success(let touristSites):
                
                completionHandler(touristSites, nil)
                
            case .error(let error):
                
                completionHandler(nil, error)
            }
        })
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: "TouristSiteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TouristSiteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

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

extension TouristSitesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let DetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        self.navigationController?.pushViewController(DetailVC, animated: true)
    }
}
