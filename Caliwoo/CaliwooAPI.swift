//
//  ShopifyAPI.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Parse

class CaliwooAPI {
    
    class func getProductsWithSuccess(success: ((products: [Product]) -> Void)) {
        Alamofire.request(ShopifyAPI.ListProducts()).responseSwiftyJSON { (request, response, json, error) -> Void in
            if (error != nil) {
                NSLog("Error: \(error)")
                println(request)
                println(response)
            }
            else {
                var products = [Product]()
                
                for (index: String, product:JSON) in json["products"] {
                    var p = Product(id: product["id"].intValue, name: product["title"].stringValue, price: product["variants"][0]["price"].doubleValue)
                    p.imageUrl = product["image"]["src"].stringValue
                    p.url = product["handle"].stringValue
                    
                    let compareAtPrice = product["variants"][0]["compare_at_price"].doubleValue
                    if (compareAtPrice > p.price) {
                        p.compareAtPrice = compareAtPrice
                    }
                    
                    products.append(p)
                }
                
                // get products likes from parse
                var query = PFQuery(className:"Product")
                query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    if (error == nil) {
                        if let objects = objects as? [PFObject] {
                            var parseProducts = [Int: PFObject]()
                            var newParseProducts = [PFObject]()
                            
                            // create array of parse products indexed by shopifyId
                            for object in objects {
                                var shopifyId = object["shopifyId"] as Int
                                parseProducts[shopifyId] = object
                            }
                            
                            // set product
                            for product in products {
                                var parseProduct = parseProducts[product.id]
                                
                                // create parse product if not found
                                if (parseProduct == nil) {
                                    parseProduct = PFObject(className: "Product")
                                    parseProduct!["shopifyId"] = product.id
                                    parseProduct!["name"] = product.name
                                    parseProduct!["likes"] = 0
                                    
                                    newParseProducts.append(parseProduct!)
                                }
                                
                                product.parse = parseProduct
                            }
                            
                            // save all parse products
                            PFObject.saveAllInBackground(newParseProducts, block: nil)
                        }
                    }
                    
                    // always success, because we want to show the products even if we can't get the number of likes
                    success(products: products)
                })
            }
        }
    }
    
    class func getProductsFromCollectionWithSuccess(collectionId: Int, success: ((products: [Product]) -> Void)) {
        Alamofire.request(ShopifyAPI.ListProductsFromCollection(collectionId)).responseSwiftyJSON { (request, response, json, error) -> Void in
            if (error != nil) {
                NSLog("Error: \(error)")
                println(request)
                println(response)
            }
            else {
                var products = [Product]()
                
                for (index: String, product:JSON) in json["products"] {
                    var p = Product(id: product["id"].intValue, name: product["title"].stringValue, price: product["variants"][0]["price"].doubleValue)
                    p.imageUrl = product["image"]["src"].stringValue
                    p.url = product["handle"].stringValue
                    
                    let compareAtPrice = product["variants"][0]["compare_at_price"].doubleValue
                    if (compareAtPrice > p.price) {
                        p.compareAtPrice = compareAtPrice
                    }
                    
                    products.append(p)
                }
                
                // get products likes from parse
                var query = PFQuery(className:"Product")
                query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    if (error == nil) {
                        if let objects = objects as? [PFObject] {
                            var parseProducts = [Int: PFObject]()
                            var newParseProducts = [PFObject]()
                            
                            // create array of parse products indexed by shopifyId
                            for object in objects {
                                var shopifyId = object["shopifyId"] as Int
                                parseProducts[shopifyId] = object
                            }
                            
                            // set product
                            for product in products {
                                var parseProduct = parseProducts[product.id]
                                
                                // create parse product if not found
                                if (parseProduct == nil) {
                                    parseProduct = PFObject(className: "Product")
                                    parseProduct!["shopifyId"] = product.id
                                    parseProduct!["name"] = product.name
                                    parseProduct!["likes"] = 0
                                    
                                    newParseProducts.append(parseProduct!)
                                }
                                
                                product.parse = parseProduct
                            }
                            
                            // save all parse products
                            PFObject.saveAllInBackground(newParseProducts, block: nil)
                        }
                    }
                    
                    // always success, because we want to show the products even if we can't get the number of likes
                    success(products: products)
                })
            }
        }
    }
    
    class func getCollectionsWithSuccess(success: ((collections: [Collection]) -> Void)) {
        Alamofire.request(ShopifyAPI.ListCollections()).responseSwiftyJSON { (request, response, json, error) -> Void in
            if (error != nil) {
                NSLog("Error: \(error)")
                println(request)
                println(response)
            }
            else {
                var collections = [Collection]()
                
                for (index: String, collection:JSON) in json["custom_collections"] {
                    var c = Collection(id: collection["id"].intValue, name: collection["title"].stringValue)
                    c.imageUrl = collection["image"]["src"].stringValue
                    c.url = collection["handle"].stringValue
                    
                    collections.append(c)
                }
                
                // always success, because we want to show the collections even if we can't get the number of likes
                success(collections: collections)
            }
        }
    }
}