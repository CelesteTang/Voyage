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
    
    case formURLFail

}

enum Result<T> {
    
    case success(T)
    
    case error(Error)
}

class DataLoader {
    
    var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func getData(url: URL, headers: [String: String]? = nil,
                 completionHandler: @escaping (Result<Data>) -> Void) -> RequestToken {
        
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }()
        
        let task = session.dataTask(with: request) { (data, _, error) in
            
            switch (data, error) {
                
            case (_, let error?):
                
                completionHandler(.error(error))
                
            case (let data?, _):
                
                completionHandler(.success(data))
                
            case (nil, nil):
                
                completionHandler(.error(NetworkError.dataTaskError))
                
            default: break
                
            }
        }
        
        task.resume()
        
        return RequestToken(task: task)
    }
}
