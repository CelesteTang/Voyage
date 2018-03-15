//
//  ReachabilityMonitor.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/15.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import Reachability

class ReachabilityMonitor {
    
    static let shared = ReachabilityMonitor()
    
    var isNetworkAvailable: Bool {
        return reachabilityStatus != .none
    }
    var reachabilityStatus: Reachability.Connection = .none
    
    var reachability = Reachability()
    
    func startMonitoring(_ handler: @escaping (Bool) -> Void) {
        
        NotificationCenter.default.addObserver(forName: .reachabilityChanged, object: reachability, queue: .main) { [unowned self] (notification) in
            
            if let reachability = notification.object as? Reachability {
                
                self.reachabilityStatus = reachability.connection
                
                switch reachability.connection {
                case .none:
                    handler(false)
                case .wifi, .cellular:
                    handler(true)
                }
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    func stopMonitoring() {
        
        reachability?.stopNotifier()
        
        NotificationCenter.default.removeObserver(self,
                                                  name: .reachabilityChanged,
                                                  object: reachability)
    }
}
