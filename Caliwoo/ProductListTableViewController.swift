//
//  ProductListTableViewController.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

class ProductListTableViewController: UITableViewController, ProductTableViewCellDelegate {
    
    var collection: Collection?
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleImage.contentMode = .ScaleAspectFit
        titleImage.image = UIImage(named: "logo")
        navigationItem.titleView = titleImage
        
//        CaliwooAPI.getProductsWithSuccess { (products) -> Void in
//            self.products = products
//            self.tableView.reloadData()
//        }
        if let collection = self.collection {
            CaliwooAPI.getProductsFromCollectionWithSuccess(collection.id, success: { (products) -> Void in
                self.products = products
                self.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as ProductTableViewCell
        
        let product = products[indexPath.row]

        // Configure the cell...
        cell.product = product;
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - ProductTableViewCellDelegate
    
    func productTableViewCellDidLikeProduct(cell: ProductTableViewCell, sender: AnyObject) {
        // if product has likes
        if var likes = cell.product?.parse?["likes"] as? Int {
            cell.productLikeButton.setTitle("\(likes+1)", forState: .Normal)
            
            // save product
            cell.product?.parse?.incrementKey("likes")
            cell.product?.parse?.saveEventually(nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}