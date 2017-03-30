//
//  DataService.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import Foundation
import Alamofire

class DataService {
    static let instance = DataService()
    
    let endpoint = "54.250.206.25:3000"
    let headers: HTTPHeaders = [
        "UserEmail": "user@todait.com",
        "UserToken": "dGUrT-tcX635Q43ka3wU"
    ]
    
    func fetchTodaysSaying(date: String, completion: @escaping (Saying) -> ()) {

        Alamofire.request("\(endpoint)/featured_sayings/\(date)", headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
            
            if let result = response.result.value {
                if let JSON = result as? [String: AnyObject], let sayingData = JSON["saying"] as? [String: AnyObject] {
                    let saying = Saying(data: sayingData)
                    completion(saying)
                }
            }
        }
    }
    
    func fetchSayingList(completion: @escaping ([Saying]) -> ()) {
        
        Alamofire.request("\(endpoint)/sayings", headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
            
            if let result = response.result.value {
                if let JSON = result as? [[String: AnyObject]] {
                    completion(JSON.map({return Saying(data: $0)}))
                }
            }
        }
    }
    
    func writeSaying(saying: Saying) {
        
        guard let body = saying.body else {
            return
        }
        
        guard let author = saying.author else {
            return
        }
        
        let imageUrl: String
        if let imgUrl = saying.image_url {
            imageUrl = imgUrl
        } else {
            imageUrl = ""
        }
        
        let parameters: Parameters = [
            "saying": [
                "id": 1,
                "body": body,
                "author": author,
                "image_url": imageUrl
            ]
        ]
        
        Alamofire.request("\(endpoint)/sayings", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
}
