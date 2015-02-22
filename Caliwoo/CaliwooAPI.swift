//
//  ShopifyAPI.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Alamofire
import SwiftyJSON

class CaliwooAPI {
    
    class func getProductsWithSuccess(success: ((products: [Product]) -> Void)) {
        Alamofire.request(ShopifyAPI.ListProducts()).responseSwiftyJSON { (request, response, json, error) -> Void in
            if (error != nil) {
                NSLog("Error: \(error)")
                println(request)
                println(response)
            }
            else {
                var products: [Product] = []
                
                for (index: String, product:JSON) in json["products"] {
                    var p = Product(id: product["id"].intValue, name: product["title"].stringValue, price: product["variants"][0]["price"].doubleValue, imageUrl: product["image"]["src"].stringValue)
                    p.url = product["handle"].stringValue
                    products.append(p)
                }
                
                success(products: products)
            }
        }
    }
}