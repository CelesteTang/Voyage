//
//  TouristSiteProviderTests.swift
//  VoyageTests
//
//  Created by 湯芯瑜 on 2018/3/16.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import XCTest
@testable import Voyage

class TouristSiteProviderTests: XCTestCase {
    
    class FakeTouristSiteProvider: TouristSiteProvidable {
        
        var touristSites: [TouristSite]?
        var error: NetworkError?
        
        func getTouristSites(completionHandler: @escaping ([TouristSite]?, Error?) -> Void) {
            completionHandler(touristSites, error)
        }
    }
    
    var touristSiteProvider: FakeTouristSiteProvider?
    
    override func setUp() {
        super.setUp()
        
        touristSiteProvider = FakeTouristSiteProvider()
    }
    
    override func tearDown() {
        
        touristSiteProvider = nil
        
        super.tearDown()
    }
    
    func testGetTouristSitesSuccess() {
        
        touristSiteProvider?.touristSites = []
        
        let promise = self.expectation(description: "Get touristSites successfully")
        touristSiteProvider?.getTouristSites { (touristSites, error) in
            touristSites != nil ? promise.fulfill() : XCTFail((error?.localizedDescription)!)
        }

        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetTouristSitesFail() {
        
        touristSiteProvider?.error = NetworkError.formURLFail
        
        let promise = self.expectation(description: "Fail to get touristSites")
        touristSiteProvider?.getTouristSites { (touristSites, error) in
            error != nil ? promise.fulfill() : XCTFail((error?.localizedDescription)!)
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
