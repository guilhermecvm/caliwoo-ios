//
//  Product.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Foundation
import Parse

class Product: NSObject {
    var id: Int
    var name: String
    var price: Double
    var compareAtPrice: Double?
    var url: String?
    var imageUrl: String
    var parse: PFObject?
    
    init(id: Int, name: String, price: Double, imageUrl: String) {
        self.id = id
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
    }

}
