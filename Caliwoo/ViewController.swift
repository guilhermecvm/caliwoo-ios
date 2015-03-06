//
//  ViewController.swift
//  Caliwoo
//
//  Created by Guilherme Miranda on 18/02/15.
//  Copyright (c) 2015 KinGui. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        titleImage.contentMode = .ScaleAspectFit
        titleImage.image = UIImage(named: "logo")
        navigationItem.titleView = titleImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

