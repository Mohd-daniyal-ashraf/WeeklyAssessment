//
//  EditViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/21/25.
//

import UIKit

class EmailEditViewController: UIViewController {

    
    @IBOutlet weak var firstInputField: UITextField!
 
    @IBOutlet weak var emailView: UIView!

    var firstInput: String = ""
    
    override func viewDidLoad() {   
        
        super.viewDidLoad()
        
        firstInputField.text = firstInput
        setUpInputView(view: emailView)
    }
    
    func setUpInputView(view: UIView) {
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
    }
    
    @IBAction func saveEEmail(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(firstInputField.text, forKey: "email")
        self.navigationController?.popViewController(animated: true)
    }
}
