//
//  DataLoaderTests.swift
//  VoyageTests
//
//  Created by 湯芯瑜 on 2018/3/16.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import XCTest
@testable import Voyage

class DataLoaderTests: XCTestCase {
    
    var dataLoader: DataLoader?
    
    override func setUp() {
        super.setUp()
        
        dataLoader = DataLoader(session: URLSession())
        
    }
    
    override func tearDown() {
        
        dataLoader = nil
        
        super.tearDown()
    }
    
    func testGetData() {
        
    }
    
}
