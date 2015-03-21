//
//  CWCache.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/20/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Parse

class CWCache {
    let cache = NSCache()
    
    // TODO: enable on xcode 6.3
//    static let sharedInstance = CWCache()
    
    // TODO: disable on xcode 6.3
    class var sharedInstance: CWCache {
        struct Singleton {
            static let instance: CWCache = CWCache()
        }
        return Singleton.instance
    }
    
    func setPhotoLikedByUser(product: PFObject, liked: Bool) {
        var attributes = getAttributesForProduct(product)
        
        if (attributes == nil) {
            attributes = [String:AnyObject]()
        }
        
        attributes!["likedByCurrentUser"] = liked
        
        setAttributesForProduct(attributes!, product: product)
    }
    
    func isProductLikedByUser(product: PFObject) -> Bool {
        var attributes = getAttributesForProduct(product)
        
        if var liked = attributes?["likedByCurrentUser"] as? Bool {
            return liked
        }
        else {
            return false
        }
    }
    
    
    // MARK: cache handling
    
    func getAttributesForProduct(product: PFObject) -> [String:AnyObject]? {
        var key = keyForProduct(product)
        return cache.objectForKey(key) as? [String:AnyObject]
    }
    
    func setAttributesForProduct(attributes: [String:AnyObject], product: PFObject) {
        var key = keyForProduct(product)
        cache.setObject(attributes, forKey: key)
    }
    
    func keyForProduct(product: PFObject) -> String {
        return "product_\(product.objectId)"
    }
}
