//
//  ProductTableViewCell.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 21/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

protocol ProductTableViewCellDelegate {
    func productTableViewCellDidLikeProduct(cell: ProductTableViewCell, sender: AnyObject)
}

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productLikeButton: UIButton!
    
    var delegate: ProductTableViewCellDelegate?
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
            
            if (product!.parse != nil) {
                var likes = product!.parse!["likes"] as Int
                self.productLikeButton.setTitle("\(likes)", forState: .Normal)
                
                if (CWCache.sharedInstance.isProductLikedByUser(product!.parse!)) {
                    self.productLikeButton.backgroundColor = UIColor(red: 244.0/255.0, green: 67.0/255.0, blue: 54.0/255.0, alpha: 1.0)
                }
                else {
                    self.productLikeButton.backgroundColor = nil
                }
            }
            else {
                self.productLikeButton.setTitle("0", forState: .Normal)
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
    
    @IBAction func likeButtonTap(sender: AnyObject) {
        delegate?.productTableViewCellDidLikeProduct(self, sender: sender)
    }
    
    @IBAction func productImageButtonDoubleTap(sender: AnyObject) {
        delegate?.productTableViewCellDidLikeProduct(self, sender: sender)
        
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
}
