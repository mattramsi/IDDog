//
//  DogListViewModel.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import Foundation
import UIKit

struct DogViewModel {
    
    let dog: Dog
    var selectedType: String = DogType.husky.rawValue
    
    init() {
        self.dog = Dog(category: "", list: [])
    }
    
    init(dog: Dog) {
        self.dog = dog
    }

}

extension DogViewModel {
    
     var types: [String] {
         return DogType.allCases.map { $0.rawValue }
     }
    
    var category: String {
        return dog.category
    }
    
    var count: Int {
        return dog.list.count
    }
    
    var list: [String] {
        return dog.list
    }
    
}

