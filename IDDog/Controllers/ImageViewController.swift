//
//  ImageViewController.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false
        view.backgroundColor = .clear
//        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: ""))
        
        Nuke.loadImage(with:  URL(string: imageUrl)!, into: imageView)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
