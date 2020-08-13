//
//  Dog.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import Foundation

struct Dog: Codable {
    
    let category: String 
    let list: [String]
    
}


extension Dog {
    
    static func byCategory(_ categoryName: String) -> Resource<Dog?> {
        
        guard let url =  URL(string: "https://iddog-nrizncxqba-uc.a.run.app/feed?category=\(categoryName)") else {
            fatalError("URL is incorrect")
        }
        
        return Resource<Dog?>(url: url)
    }
    
}


