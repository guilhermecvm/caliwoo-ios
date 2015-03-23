//
//  MenuTableViewCell.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 3/11/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import Alamofire

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionName: UILabel!
    
    var collection: Collection? {
        didSet {
            self.collectionName.text = collection!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        var bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 149.0/255.0, green: 209.0/255.0, blue: 215.0/255.0, alpha: 1)
        self.selectedBackgroundView = bgColorView
    }

}
