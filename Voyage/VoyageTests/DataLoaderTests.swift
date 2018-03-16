//
//  DataLoaderTests.swift
//  VoyageTests
//
//  Created by 湯芯瑜 on 2018/3/16.
//  Copyright © 2018年 Hsin-Yu Tang. All rights reserved.
//

import XCTest
@testable import Voyage

extension Dictionary {
    
    internal func toJsonString() -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                print("\(#file, #function) ERROR: Dictionary can't be converted to String)")
                return nil
            }
            return jsonString
        } catch {
            print("\(#file, #function) ERROR: \(String(describing: error))")
            return nil
        }
    }
}

class DataLoaderTests: XCTestCase {
    
    class FakeDataLoader: NetworkService {
        
        var jsonObject: [String: Any]!
        
        private func convertJsonObjectToData(jsonObject: [String: Any]) -> Data {
            let jsonStr = jsonObject.toJsonString()
            guard let data = jsonStr?.data(using: .utf8) else {
                return Data()
            }
            return data
        }
        
        func getData(url: URL, headers: [String : String]?, completionHandler: @escaping (Result<Data>) -> Void) -> RequestToken {
            
            let data = self.convertJsonObjectToData(jsonObject: jsonObject)
            completionHandler(.success(data))
            
            return RequestToken(task: nil)
        }
    }
    
    var dataLoader: FakeDataLoader?
    
    override func setUp() {
        super.setUp()
        
        dataLoader = FakeDataLoader()
        
    }
    
    override func tearDown() {
        
        dataLoader = nil
        
        super.tearDown()
    }
    
    func testGetData() {
        
        let serverData = [
            "_id": "1",
            "RowNumber": "1",
            "REF_WP": "10",
            "CAT1": "景點",
            "CAT2": "養生溫泉",
            "SERIAL_NO": "2011051800000061",
            "MEMO_TIME": "各業者不同，依據現場公告",
            "stitle": "新北投溫泉區",
            "xbody": "北投溫泉從日據時代便有盛名，深受喜愛泡湯的日人自然不會錯過，瀧乃湯、星乃湯、鐵乃湯就是日本人依照溫泉的特性與療效給予的名稱，據說對皮膚病、神經過敏、氣喘、風濕等具有很好的療效，也因此成為了北部最著名的泡湯景點之一。新北投溫泉的泉源為大磺嘴溫泉，泉質屬硫酸鹽泉，PH值約為3~4之間，水質呈黃白色半透明，泉水溫度約為50-90℃，帶有些許的硫磺味 。目前北投的溫泉旅館、飯店、會館大部分集中於中山路、光明路沿線以及北投公園地熱谷附近，總計約有44家，每一家都各有其特色，多樣的溫泉水療以及遊憩設施，提供遊客泡湯養生，而鄰近的景點也是非常值得造訪，例如被列為三級古蹟的三寶吟松閣、星乃湯、瀧乃湯以及北投第一家溫泉旅館「天狗庵」，都有著深遠的歷史背景，而北投公園、北投溫泉博物館、北投文物館、地熱谷等，更是遊客必遊的景點，來到北投除了可以讓溫泉洗滌身心疲憊，也可以順便了解到北投溫泉豐富的人文歷史。",
            "avBegin": "2010/02/14",
            "avEnd": "2016/07/07",
            "idpt": "臺北旅遊網",
            "address": "臺北市  北投區中山路、光明路沿線",
            "xpostDate": "2016/07/07",
            "file": "http://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11000848.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/pic/11002891.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D315/E70/F65/1e0951fb-069f-4b13-b5ca-2d09df1d3d90.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D260/E538/F274/e7d482ba-e3c0-40c3-87ef-3f2a1c93edfa.JPGhttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C0/D919/E767/F581/9ddde70e-55c2-4cf0-bd3d-7a8450582e55.jpghttp://www.travel.taipei/d_upload_ttn/sceneadmin/image/A0/B0/C1/D28/E891/F188/77a58890-7711-4ca2-aebe-4aa379726575.JPG",
            "langinfo": "10",
            "POI": "Y",
            "info": "新北投站下車，沿中山路直走即可到達公車：216、218、223、230、266、602、小6、小7、小9、、小22、小25、小26至新北投站下車",
            "longitude": "121.508447",
            "latitude": "25.137077",
            "MRT": "新北投"]
        
        dataLoader?.jsonObject = serverData
        let promise = self.expectation(description: "Get data successfully")
        _ = dataLoader?.getData(url: URL(string: "test")!, headers: nil) { (result) in
            
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                promise.fulfill()
            case .error(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
}
