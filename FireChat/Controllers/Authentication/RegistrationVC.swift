//
//  RegistrationVC.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 06/04/2021.
//

import UIKit
import Firebase
import SPAlert

class RegistrationVC: UIViewController {
    
    // MARK: - Properties
    
    private var registrationVM = RegisterViewModel()
    private var profileImage: UIImage?
    private let addImage: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: nameTextView)
    }()
    
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextView)
    }()
    
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextView)
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = .clear
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.5
        button.setHeight(height: 40)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        return button
    }()
    
    private let nameTextView = CustomTextFields(placeholder: "Username")
    
    private let emailTextView: CustomTextFields = {
        let tf = CustomTextFields(placeholder: "Email Address")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextView: CustomTextFields = {
        let tf = CustomTextFields(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "I Have an Account! ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc func selectPhoto(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func goToLogin(){
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == nameTextView {
            registrationVM.username = sender.text
        }  else if sender == emailTextView {
            registrationVM.email = sender.text
        } else{
            registrationVM.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func registerUser(){
        guard let username = nameTextView.text else { return }
        guard let email = emailTextView.text else { return }
        guard let password = passwordTextView.text else { return }
        guard let proImage = profileImage else { return }
        
        showLoader(true, withText: "Registering You")
        let credentials = RegistrationCredentials(name: username, email: email, password: password, profileImage: proImage)
        AuthService.shared.createUser(credentials: credentials) { (error) in
            if let error = error {
                SPAlert.present(title: "Error", message: "\(error.localizedDescription)", preset: .error)
                print("Error: \(error.localizedDescription)")
                self.showLoader(false)
                return
            } else {
                self.showLoader(false)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        setupToHideKeyboardOnTapOnView()
        configureGradientLayer()
        view.addSubview(addImage)
        addImage.centerX(inView: view)
        addImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        addImage.setDimensions(height: 120, width: 120)
        
        
        let stack = UIStackView(arrangedSubviews: [nameContainerView, emailContainerView, passwordContainerView, registerButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: addImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(loginButton)
        loginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        configureNotificationObservers()
    }
    
    func configureNotificationObservers(){
        nameTextView.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextView.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextView.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
}

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        addImage.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        addImage.layer.borderColor = UIColor.white.cgColor
        addImage.layer.borderWidth = 3.0
        addImage.layer.cornerRadius = 120/2
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationVC: AuthenticationControllerProtocal {
    func checkFormStatus(){
        if registrationVM.formIsValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .clear
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }}
