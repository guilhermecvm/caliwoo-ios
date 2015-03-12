//
//  Collection.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/11/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Foundation

class Collection: NSObject {
    var id: Int
    var name: String
    var url: String?
    var imageUrl: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
   
}
