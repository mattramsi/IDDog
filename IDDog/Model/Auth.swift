//
//  Auth.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import Foundation

struct Auth: Codable {
    
    var user: User
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decode(User.self, forKey: .user)
    }
    
    private enum CodingKeys: String, CodingKey {
        case user = "user"
    }
}

struct Login: Codable {
    
    var email: String
    
    init(vm: LoginViewModel) {
        self.email = vm.email
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        email = try container.decode(String.self, forKey: .email)
    }
    
    private enum CodingKeys: String, CodingKey {
        case email = "email"
    }
    
}

extension Auth {
    
    static func login(vm: LoginViewModel) -> Resource<Auth?> {
        
        let login = Login(vm: vm)
        
        guard let url =  URL(string: "https://iddog-nrizncxqba-uc.a.run.app/signup") else {
            fatalError("URL is incorrect")
        }
        
        guard let data = try? JSONEncoder().encode(login) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Auth?>(url: url)
        resource.httpMethod = .post
        resource.body = data
        
        return resource
    }
    
}


struct User: Codable {
    
    var token: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
    }
    
    private enum CodingKeys: String, CodingKey {
        case token = "token"
    }
}
