//
//  ProductTableViewCell.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productLikeButton: UIButton!
    
    var product: Product? {
        didSet {
//            self.productImageView.image = nil
            
            if let imageUrl = product!.imageUrl {
                Alamofire.request(.GET, imageUrl).validate(contentType: ["image/*"]).responseImage() {
                    (request, _, image, error) in
                    if error == nil && image != nil {
                        self.productImageButton.setBackgroundImage(image, forState: .Normal)
                    }
                }
            }
            
            self.productName.text = product!.name
            
            if let compareAtPrice = product!.compareAtPrice {
                self.productPrice.text = "De R$ \(compareAtPrice) Por R$ \(product!.price)"
            }
            else {
                self.productPrice.text = "R$ \(product!.price)"
            }
            
            
            if let likes = product?.parse?["likes"] as? Int {
                self.productLikeButton.setTitle("\(likes)", forState: .Normal)
            }
            else {
                self.productLikeButton.setTitle("curtir", forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func likeProduct() {
        if var likes = self.product?.parse?["likes"] as? Int {
            self.productLikeButton.setTitle("\(likes+1)", forState: .Normal)
            self.product?.parse?.incrementKey("likes")
            
            self.product?.parse?.saveEventually(nil)
        }
        else {
            self.productLikeButton.setTitle("1", forState: .Normal)
            
            // fetch product
            var query = PFQuery(className:"Product")
            query.whereKey("shopifyId", equalTo: self.product?.id)
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if (error == nil) {
                    if (objects.count == 0) {
                        // create product if not found
                        var parse = PFObject(className: "Product")
                        parse["shopifyId"] = self.product?.id
                        parse["name"] = self.product?.name
                        parse.incrementKey("likes")
                        self.product?.parse = parse
                    }
                    else {
                        objects[0].incrementKey("likes")
                        self.product?.parse = objects[0] as? PFObject
                    }
                    
                    self.product?.parse?.saveEventually(nil)
                }
            })
        }
        
        // heart animation
        let imageView = UIImageView(frame: self.productImageButton.frame)
        imageView.image = UIImage(named: "heart")
        imageView.contentMode = .Center
        self.addSubview(imageView)
        
        UIView.animateKeyframesWithDuration(0.75, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: { () -> Void in
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
            })
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.75, animations: { () -> Void in
                imageView.alpha = 0
            })
        }) { (finished) -> Void in
            imageView.removeFromSuperview()
        }
    }
    
    @IBAction func likeButtonTap(sender: AnyObject) {
        self.likeProduct()
        
    }
    
    @IBAction func productImageButtonDoubleTap(sender: AnyObject) {
        self.likeProduct()
    }
}
