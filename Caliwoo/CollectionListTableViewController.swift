//
//  CollectionListTableViewController.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/11/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

class CollectionListTableViewController: UITableViewController {
    
    var collections: [Collection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleImage.contentMode = .ScaleAspectFit
        titleImage.image = UIImage(named: "logo")
        navigationItem.titleView = titleImage
        
        CaliwooAPI.getCollectionsWithSuccess { (collections) -> Void in
            self.collections = collections
            self.tableView.reloadData()
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
        return collections.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CollectionTableViewCell
        
        let collection = collections[indexPath.row]
        
        // Configure the cell...
        cell.collection = collection;
        
        return cell
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let productListTableViewController = segue.destinationViewController as ProductListTableViewController
        productListTableViewController.collection = (sender as CollectionTableViewCell).collection
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

}
