//
//  Model.swift
//  Sayings
//
//  Created by Hyunsoo Park on 3/29/17.
//  Copyright © 2017 Hyunsoo Park. All rights reserved.
//

import Foundation

class Saying: NSObject {
    var id: Int?
    var body: String?
    var author: String?
    var image_url: String?
    //var user_id: Int?
    
    override init() {}
    init(data: [String: AnyObject]) {
        super.init()
        setValuesForKeys(data)
    }
}
