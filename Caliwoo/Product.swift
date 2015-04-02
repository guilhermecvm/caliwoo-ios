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
    var images = [String]()
    var parse: PFObject?
    
    init(id: Int, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }

}
