//
//  ShopifyAPI2.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import Alamofire

enum ShopifyAPI: URLRequestConvertible {
    static var baseURLString: String = ""
    static var OAuthToken: String?
    
    case ListProducts()
    case ReadProduct(String)
    
    var method: Alamofire.Method {
        switch self {
        case .ListProducts:
            return .GET
        case .ReadProduct:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .ListProducts:
            return "/admin/products.json"
        case .ReadProduct(let id):
            return "/admin/products/\(id).json"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: ShopifyAPI.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = ShopifyAPI.OAuthToken {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "X-Shopify-Access-Token")
        }
        
        return mutableURLRequest
    }
}