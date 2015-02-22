//
//  Product.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Foundation

class Product: NSObject {
    let id: Int
    let url: String
    let name: String
    let imageUrl: String
    
    init(id: Int, url: String, name: String, imageUrl: String) {
        self.id = id
        self.url = url
        self.name = name
        self.imageUrl = imageUrl
    }

}
