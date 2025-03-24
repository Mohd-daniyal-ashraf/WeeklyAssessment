//
//  ProfileViewController.swift
//  WeeklyAssessment
//
//  Created by Mddaniyal on 3/21/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var addressView: UIView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imgView.layer.cornerRadius = imgView.frame.height / 2
        passwordInput.isSecureTextEntry = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        nameInput.layer.cornerRadius = 10
        
        setUpInputView(view: nameView)
        setUpInputView(view: emailView)
        setUpInputView(view: mobileView)
        setUpInputView(view: addressView)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard

        if let fullname = defaults.string(forKey: "username") {
            nameInput.text = fullname
        }

        if let email = defaults.string(forKey: "email") {
            emailInput.text = email
        }

        if let password = defaults.string(forKey: "password") {
            passwordInput.text = password
        }
    }
    
    @IBAction func imgSelectBtn(_ sender: Any) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true)
    }
    
    
    @IBAction func editEmailBtn(_ sender: Any) {
        
        if let storyboard = storyboard?.instantiateViewController(withIdentifier: "EmailEditViewController") as? EmailEditViewController {
            
            if let emailText = emailInput.text {
                storyboard.firstInput = emailText
            }
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
    
    @IBAction func editPasswordBtn(_ sender: Any) {
        
        if let storyboard = storyboard?.instantiateViewController(withIdentifier: "PasswordEditViewController") as? PasswordEditViewController {
            
            if let passwordText = passwordInput.text {
                storyboard.firstInput = passwordText
            }
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
    }
    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let selectedImage = info[.editedImage] as? UIImage {
                imgView.image = selectedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                imgView.image = originalImage
            }
            picker.dismiss(animated: true)
        }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    func setUpInputView(view: UIView) {
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.3
    }
}
