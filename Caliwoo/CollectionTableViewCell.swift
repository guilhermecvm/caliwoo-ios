//
//  CollectionTableViewCell.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/11/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionImageView: UIImageView!
    
    var collection: Collection? {
        didSet {
//            self.collectionImageView.image = nil
            
            if let imageUrl = collection!.imageUrl {
                Alamofire.request(.GET, imageUrl).validate(contentType: ["image/*"]).responseImage() {
                    (request, _, image, error) in
                    if error == nil && image != nil {
                        let imageView = UIImageView(frame: self.frame)
                        self.collectionImageView.image = image
                    }
                }
            }
            
            self.collectionName.text = collection!.name
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

}
