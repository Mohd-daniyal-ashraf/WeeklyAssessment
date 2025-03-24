//
//  EditCellViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/24/25.
//

import UIKit

protocol EditCellViewControllerDelegate {
    
    func UpdateUser(_ updatedUser: User, at index: Int)
}

class EditCellViewController: UIViewController {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var descriptionView: UIView!

    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!

    var userIndex: Int?
    
    var image: String = ""
    var name: String = ""
    var email: String = ""
    var address: String = ""
    var descripon: String = ""

    var delegate: EditCellViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpInputView(view: imageView)
        setUpInputView(view: nameView)
        setUpInputView(view: emailView)
        setUpInputView(view: addressView)
        setUpInputView(view: descriptionView)
    }
    
    func setUpInputView(view: UIView) {
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
        
        imageTextField.text = image
        nameTextField.text = name
        emailTextField.text = email
        addressTextField.text = address
        descriptionTextField.text = descripon
    }
    
    @IBAction func saveNotificationBtnTapped(_ sender: Any) {
        
        guard let image = imageTextField.text, !image.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let description = descriptionTextField.text, !description.isEmpty else {
            
            let alert = UIAlertController(title: "All field required", message: "All field must be filled", preferredStyle: .alert)
            
            let okey = UIAlertAction(title: "Okey", style: .default)
            alert.addAction(okey)
            
            present(alert, animated: true)
            
            return
        }
        
        let updatedUser = User(
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            address: addressTextField.text ?? "",
            description: descriptionTextField.text ?? "",
            imageName: imageTextField.text ?? ""
        )
        
        self.delegate?.UpdateUser(updatedUser, at: userIndex!)
        self.dismiss(animated: true)
    }
}
