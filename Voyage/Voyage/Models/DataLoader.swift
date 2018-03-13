//
//  DataLoader.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case dataTaskError
    
    case parseError
}

enum Result<T> {
    
    case success(T)
    
    case error(Error)
}

class DataLoader {
    
    let session = URLSession.shared
    
    @discardableResult
    func getData(url: URL, headers: [String: String]? = nil, completionHandler: @escaping (Result<[TouristSite]>) -> Void) -> RequestToken {
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }()
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            switch (data, error) {
                
            case (_, let error?):
                
                completionHandler(.error(error))
                
            case (let data?, _):
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let sitesData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    
                    guard let result = sitesData?["result"] as? [String: AnyObject],
                    let sitesArray = result["results"] as? [AnyObject] else {
                            return
                    }
                    
                    let sitesArrayData = try JSONSerialization.data(withJSONObject: sitesArray, options: .prettyPrinted)
                    
                    let sites = try decoder.decode([TouristSite].self, from: sitesArrayData)
                    
                    completionHandler(.success(sites))
                    
                } catch {
                    
                    completionHandler(.error(error))
                    
                }
                
            case (nil, nil):
                
                completionHandler(.error(NetworkError.dataTaskError))
                
            default:
                
                break
                
            }
        }
        
        task.resume()
        
        return RequestToken(task: task)
    }
}
