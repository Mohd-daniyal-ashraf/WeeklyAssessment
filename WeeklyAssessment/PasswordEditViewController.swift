//
//  PasswordEditViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/23/25.
//

import UIKit

class PasswordEditViewController: UIViewController {
    
    @IBOutlet weak var firstInputField: UITextField!
    @IBOutlet weak var secondInputField: UITextField!
    @IBOutlet weak var thirdInputField: UITextField!

    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var newPasswordView: UIView!
    @IBOutlet weak var conformPasswordView: UIView!
    
    var firstInput: String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        firstInputField.text = firstInput
        
        firstInputField.text = firstInput
        setUpInputView(view: passwordView)
        setUpInputView(view: newPasswordView)
        setUpInputView(view: conformPasswordView)
        thirdInputField.isSecureTextEntry = true
    }
    
    func setUpInputView(view: UIView) {
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
    }
    
    @IBAction func passwordUpdateBtnTapped(_ sendeer: Any) {
        
        guard let newPassword = secondInputField.text, !newPassword.isEmpty,
              let confirmPassword = thirdInputField.text, !confirmPassword.isEmpty else {
            print("Fields cannot be empty")
            return
        }
        
        if newPassword != confirmPassword {

            let alert = UIAlertController(title: "Password does't match", message: "New password and conform password must be same", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Okey", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(newPassword, forKey: "password")
        self.navigationController?.popViewController(animated: true)
    }
}
