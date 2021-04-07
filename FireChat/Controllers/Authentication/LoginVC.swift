//
//  LoginVC.swift
//  FireChat
//
//  Created by Dr.Drake 007 on 06/04/2021.
//

import UIKit

protocol AuthenticationControllerProtocal {
    func checkFormStatus()
}

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    private var loginViewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "logo")
        iv.tintColor = .white
        return iv
    }()
    
    private lazy var emailContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextView)
    }()
    
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextView)
    }()
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        //button.backgroundColor = .clear
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.5
        button.setHeight(height: 40)
        button.setTitleColor(UIColor.white, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(getLoginInfo), for: .touchUpInside)
        return button
    }()
    
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
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't Have an Account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Selectors
    @objc func goToRegister(){
        let registerVC = RegistrationVC()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextView {
            loginViewModel.email = sender.text
        } else{
            loginViewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func getLoginInfo(){
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        setupToHideKeyboardOnTapOnView()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 100, width: 70)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(registerButton)
        registerButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        emailTextView.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextView.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}
extension LoginVC: AuthenticationControllerProtocal {
    func checkFormStatus(){
        if loginViewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .clear
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
}
