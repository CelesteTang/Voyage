//
//  StringExtensionTests.swift
//  VoyageTests
//
//  Created by 湯芯瑜 on 2018/3/16.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import XCTest
@testable import Voyage

class StringExtensionTests: XCTestCase {
    
    var string: String = ""
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        string = ""
        super.tearDown()
    }

    func testIsjpg() {
        string = "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpg"
        let isJpg = string.isJpg()
        XCTAssertTrue(isJpg, "string has hasSuffix 'jpg'")
    }
    
    func testIsJPG() {
        string = "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.JPG"
        let isJpg = string.isJpg()
        XCTAssertTrue(isJpg, "string has hasSuffix 'JPG'")
    }
    
    func testIsNotJPG() {
        string = "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.mp3"
        let isJpg = string.isJpg()
        XCTAssertFalse(isJpg, "string doesn't has hasSuffix 'jpg' or 'JPG'")
    }
    
    func testStringToURLs() {
        
        let URLs = [
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpg")!,
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpg")!,
            URL(string: "http://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D611/E706/F767/6fb1cf1e-2a55-4f91-869f-c8f351eb930e.JPG")!
        ]
        
        string = """
        http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11001481.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C2/D74/E860/F223/f28f9ff0-a457-4687-8630-bb5bfb793d46.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D611/E706/F767/6fb1cf1e-2a55-4f91-869f-c8f351eb930e.JPGhttp://www.travel.taipei/streams/scenery_file_audio/c24.mp3http://www.travel.taipei/streams/video/DISC1-04.flv
        """
        let urls = string.toURLArray()
        
        XCTAssertEqual(urls.count, URLs.count, "URL should be the same")
        XCTAssertEqual(urls, URLs, "URL should be the same")
    }
    
}
