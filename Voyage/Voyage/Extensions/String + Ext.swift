//
//  String + Ext.swift
//  Voyage
//
//  Created by 湯芯瑜 on 2018/3/14.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import Foundation

extension String {
    
    func toURLArray() -> [String] {
        return self.components(separatedBy: "http")
            .filter{ $0 != "" && $0.isJpg()}
            .map{ "http\($0)" }
    }
    
    func isJpg() -> Bool {
        return self.hasSuffix("jpg") || self.hasSuffix("JPG")
    }
}
