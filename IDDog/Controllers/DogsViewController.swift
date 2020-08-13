//
//  DogsViewController.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class DogsViewController: UIViewController {
    
    private var vm = DogViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    private var dogTypesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()
        populateImages()
    }
    
    private func setupUI() {
        
        dogTypesSegmentedControl = UISegmentedControl(items: self.vm.types)
        dogTypesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dogTypesSegmentedControl)
        dogTypesSegmentedControl.topAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -50).isActive = true
        dogTypesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dogTypesSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for:.valueChanged)
        
        dogTypesSegmentedControl.selectedSegmentIndex = 0
    }
    
    
    private func setupUIViewEmptyCollection() {
        
        if vm.list.isEmpty {
            let label = UILabel(frame: collectionView.frame)
            label.text = "Não possuímos imagens para esses cãozinhos!"
            label.numberOfLines = 0
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tag = 2
            label.textColor = .black
            collectionView.addSubview(label)
            
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            
        } else {
            removeUIViewEmptyCollection()
        }
        
    }
    
    private func removeUIViewEmptyCollection() {
        
        for view in collectionView.subviews {
            if let subview = collectionView.viewWithTag(2) {
                subview.removeFromSuperview()
            }
        }
    }
    
    private func reloadData() {
        self.collectionView.reloadData()
        self.setupUIViewEmptyCollection()
    }
    
    @objc func segmentedControlValueChanged() {
        vm.selectedType = getSelectedType
        populateImages()
    }
    
    private var getSelectedType: String {
        return vm.types[self.dogTypesSegmentedControl.selectedSegmentIndex]
    }
    
    private func populateImages() {
        
        Webservice().load(resource: Dog.byCategory(vm.selectedType)) { [weak self] result in
            
            switch result {
            case .success(let dog):
         
                if let dog = dog {
                    self?.vm = DogViewModel(dog: dog)
                    self?.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension DogsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageUrl = vm.list[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCollectionViewCell", for: indexPath) as! DogCollectionViewCell
        
        Nuke.loadImage(with:  URL(string: imageUrl)!, into: cell.dogIV)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        let imageUrl = vm.list[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ImageViewController") as? ImageViewController {
            vc.imageUrl = imageUrl
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }

    }
    

}

