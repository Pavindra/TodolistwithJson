//
//  Tasks.swift
//  TodolistwithJson
//
//  Created by Pavindra Weththasinghe on 3/5/19.
//  Copyright © 2019 Pavindra Weththasinghe. All rights reserved.
//

import Foundation

struct Tasks {
    var task:String = ""
    var cat:String = ""
    var isImp:Bool = true
    
    init(_ dictionary: [String:Any])
    {
        self.task = dictionary["task"] as? String ?? ""
        self.cat = dictionary["category"] as? String ?? ""
        self.isImp = dictionary["isImportant"] as? Bool ?? true
    }
}
