//
//  RequestToken.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/13.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

class RequestToken {
    
    private weak var task: URLSessionTask?
    
    init(task: URLSessionTask) {
        
        self.task = task
    }
    
    func cancel() {
        
        task?.cancel()
    }
}
