//
//  ProductDetailViewController.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/31/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire
import Haneke

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Product!
    var images = [UIImage]()
    var imagePageViews = [UIImageView?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageSlider()
        
        // details
        productName.text = product.name
        
        if let compareAtPrice = product.compareAtPrice {
            productPrice.text = "De R$ \(compareAtPrice) Por R$ \(product.price)"
        }
        else {
            productPrice.text = "R$ \(product.price)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        // check if width != from 600 because this is called multiple times, even before autolayout
        if imageScrollView.frame.width != 600 {
            imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width * CGFloat(product.images.count), height: imageScrollView.frame.height)
            loadVisiblePages()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initImageSlider() {
        imagePageControl.currentPage = 0
        imagePageControl.numberOfPages = product.images.count
        
        for page in 0..<product.images.count {
            let newPageView = UIImageView()
            newPageView.contentMode = .ScaleAspectFit
            newPageView.hnk_setImageFromURL(NSURL(string: product.images[page])!, format: Format<UIImage>(name: "original"))
            
            imagePageViews.append(newPageView)
        }
    }
    
    // MARK: - image slider
    func loadPage(page: Int) {
        if page < 0 || page >= product.images.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        var frame = imageScrollView.bounds
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0.0
        
        let newPageView = imagePageViews[page]!
        newPageView.frame = frame
        imageScrollView.addSubview(newPageView)
    }
    
    func purgePage(page: Int) {
        if page < 0 || page >= product.images.count {
            // If it's outside the range of what you have to display, then do nothing
            return
        }
        
        // Remove a page from the scroll view
        if let pageView = imagePageViews[page] {
            pageView.removeFromSuperview()
        }
    }
    
    func loadVisiblePages() {
        // First, determine which page is currently visible
        let pageWidth = imageScrollView.frame.size.width
        let page = Int(floor((imageScrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        // Update the page control
        imagePageControl.currentPage = page
        
        // Work out which pages you want to load
        let firstPage = page - 1
        let lastPage = page + 1
        
        // Purge anything before the first page
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        // Load pages in our range
        for index in firstPage...lastPage {
            loadPage(index)
        }
        
        // Purge anything after the last page
        for var index = lastPage+1; index < product.images.count; ++index {
            purgePage(index)
        }
    }
    
    // MARK - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Load the pages that are now on screen
        loadVisiblePages()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
