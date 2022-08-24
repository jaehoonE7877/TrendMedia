//
//  ImageSearchAPIManager.swift
//  TrendMedia
//
//  Created by Seo Jae Hoon on 2022/08/24.
//

import UIKit

import Alamofire
import SwiftyJSON

//싱글톤 패턴은 클래스로만 만든다 vs 구조체 싱글턴 패턴
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() { }
    
    typealias completionHandler = (String) -> ()
    
    
    // escaping 키워드 안에서 작성한 클로저(컴플리션핸들러)가 밖에서 사용될 때
    func fetchImageData(query: String, completionHandler: @escaping completionHandler) {
        
        //한글로 변환
        let kText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let kText = kText else { return }
        
        let url = EndPoint.imageSearchURL + "query=\(String(describing: kText))&display=1&start=1"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //파라미터 위치는 일정함
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData(queue: .global()) { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let item = json["items"][0]["link"].stringValue
                //print(item)
               completionHandler(item)
                
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
}
