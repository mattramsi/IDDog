//
//  ViewController.swift
//  IDDog
//
//  Created by Matheus Ramos on 12/08/20.
//  Copyright © 2020 Matheus. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginViewModel = LoginViewModel()
    
    @IBOutlet weak var emailTextField: EmailBindingTextField! {
        didSet {
            emailTextField.bind { self.loginViewModel.email = $0 }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        
        if emailTextField.isValid {
            
            Webservice().load(resource: Auth.login(vm: loginViewModel)) {(result) in
                
                switch result {
                case .success(let auth):
                    
                    if let auth = auth {
                        UserDefaults.standard.set(auth.user.token, forKey: "Authorization")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = storyboard.instantiateViewController(identifier: "DogsViewController") as? DogsViewController {
                            let nav = StandardNavigationController(rootViewController: vc)
                            self.present(nav, animated: true, completion: nil)
                        }
                        
                    }
                    
                    print(auth)
                case .failure(let error):
                    print(error)
                }
                
            }
            
        } else {
            print("Email inválido!")
            let alert = UIAlertController(title: "Email inválido!", message: "Por favor verifique seu e-mail", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

            self.present(alert, animated: true)
        }
        
    }
    
}

