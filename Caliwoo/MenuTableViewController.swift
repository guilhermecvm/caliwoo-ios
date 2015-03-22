//
//  MenuTableViewController.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/11/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

class MenuTableViewController: UITableViewController {
    
    var selectedMenuItem = NSIndexPath(forRow: 0, inSection: 0)
    var collections: [Collection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleImage.contentMode = .ScaleAspectFit
        titleImage.image = UIImage(named: "logo")
        navigationItem.titleView = titleImage
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.contentInset = UIEdgeInsetsMake(44.0, 0, 0, 0)
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        else {
            return collections.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as MenuTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        if (indexPath.section == 0) {
            cell.collectionName.text = "Home"
        }
        else {
            let collection = collections[indexPath.row]
            
            // Configure the cell...
            cell.collection = collection;
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (selectedMenuItem.section == indexPath.section && selectedMenuItem.row == indexPath.row) {
            return
        }
        
        selectedMenuItem = indexPath
        
        //Present new view controller
        var destViewController : UIViewController
        
        switch (indexPath.section) {
            case 0:
                destViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as MainViewController
                break
            default:
                destViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductListTableViewController") as ProductListTableViewController
                (destViewController as ProductListTableViewController).collection = collections[indexPath.row]
                break
        }
        
        sideMenuController()?.setContentViewController(destViewController)
    }
}
