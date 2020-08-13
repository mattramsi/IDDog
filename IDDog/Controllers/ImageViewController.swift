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
        
        loadImage()
        addBlurEffectView()
    }
    
    private func loadImage() {
        Nuke.loadImage(with:  URL(string: imageUrl)!, into: imageView)
    }
    
    private func addBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        view.bringSubviewToFront(imageView)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (close))
        blurEffectView.addGestureRecognizer(gesture)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
