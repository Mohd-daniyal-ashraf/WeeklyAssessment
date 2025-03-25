//
//  LoginViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/23/25.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var outerView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        emailView.layer.cornerRadius = 10
        passwordView.layer.cornerRadius = 10
        outerView.layer.cornerRadius = 30
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        guard let emailText = emailTextField.text, !emailText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            
            let alert = UIAlertController(title: "Fields are missing",
                                          message: "Fill all requireed fieeld",
                                          preferredStyle: .alert)
            
            let okey = UIAlertAction(title: "Okey", style: .default, handler: nil)
            alert.addAction(okey)
            
            return self.present(alert, animated: true)
        }
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "email") != nil && defaults.string(forKey: "password") != nil {
            
            let storyBorad = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBorad.instantiateViewController(withIdentifier: "TabbarController")
            
            self.navigationController?.pushViewController(viewController, animated: true)
                
        } else {
            
            let alert = UIAlertController(title: "Sign Up Required",
                                          message: "No user details found. Please sign up first.",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { _ in
                
                let storyBorad = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBorad.instantiateViewController(withIdentifier: "ViewController")
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }))
                        
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUPBtn(_ sender: Any) {
        
        let storyBorad = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBorad.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
     
    }
    
}
