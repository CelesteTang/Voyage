//
//  TouristSiteProvider.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/14.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

class TouristSiteProvider {
    
    var dataLoader: NetworkService
    private var requestToken: RequestToken? = nil
    private var offset = 0
    
    init(dataLoader: NetworkService) {
        self.dataLoader = dataLoader
    }
    
    func getTouristSites(completionHandler: @escaping ([TouristSite]?, Error?) -> Swift.Void) {
                
        guard let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=36847f3f-deff-4183-a5bb-800737591de5&offset=\(offset)&limit=10") else {
            completionHandler(nil, NetworkError.formURLFail)
            return
        }
        
        requestToken = dataLoader.getData(url: url, headers: nil, completionHandler: { [unowned self] result in
            
            switch result {
                
            case .success(let data):
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let sitesObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    
                    guard let result = sitesObject?["result"] as? [String: AnyObject],
                        let sitesArray = result["results"] as? [AnyObject] else {
                            completionHandler(nil, NetworkError.parseError)
                            return
                    }
                    
                    let sitesArrayData = try JSONSerialization.data(withJSONObject: sitesArray, options: .prettyPrinted)
                    
                    let touristSites = try decoder.decode([TouristSite].self, from: sitesArrayData)
                    
                    self.offset += 10
                    
                    completionHandler(touristSites, nil)
                    
                } catch {
                    
                    completionHandler(nil, error)

                }
                
            case .error(let error):
                
                completionHandler(nil, error)
            }
        })
    }
}
