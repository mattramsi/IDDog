//
//  LoginViewModelTests.swift
//  IDDogTests
//
//  Created by Matheus Ramos on 13/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import XCTest
@testable import IDDog

class LoginViewModelTests: XCTestCase {
    
    private var vm: LoginViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vm = LoginViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_email_is_empty() throws {
        vm.email = ""
        XCTAssertEqual(vm.email.isEmpty, true)
    }
    
    func test_email_with_incorrect_format() throws {
        vm.email = "adakdaskdj.aksajs.com"
        XCTAssertEqual(emailIsValid(vm.email), false)
    }
    
    func test_email_with_correct_format() throws {
       vm.email = "matheus@gmail.com"
       XCTAssertEqual(emailIsValid(vm.email), true)
    }

}

extension LoginViewModelTests {
    
    func emailIsValid(_ text: String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailPred.evaluate(with: text)
    }
    
}
