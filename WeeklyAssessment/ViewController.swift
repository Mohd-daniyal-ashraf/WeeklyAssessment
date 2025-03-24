//
//  ViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/20/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var emailTextField: UIView!
    @IBOutlet weak var passwordTextField: UIView!
    @IBOutlet weak var fullnameTextField: UIView!
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullname: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpSignUpForm()
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        guard let emailText = email.text, isValidEmail(emailText) else {
            let alert = UIAlertController(title: "Email is not valid!", message: "Please enter a vlid email address", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            return present(alert, animated: true, completion: nil)
        }

        guard let passwordText = password.text, passwordText.count > 7 else {
            let alert = UIAlertController(title: "Not a strong password", message: "Password should be more then 8 in length", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            return present(alert, animated: true, completion: nil)
        }
        
        let defaults = UserDefaults.standard
        
        defaults.set(fullname.text, forKey: "username")
        defaults.set(email.text, forKey: "email")
        defaults.set(password.text, forKey: "password")
        
        
        let storyBorad = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBorad.instantiateViewController(withIdentifier: "TabbarController")
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController {
    
    func setUpSignUpForm() {
        
        outerView.layer.cornerRadius = 30
        emailTextField.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        fullnameTextField.layer.cornerRadius = 15
        signupBtn.layer.cornerRadius = 30
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

