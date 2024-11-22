//
//  SingInViewController.swift
//  EventHub
//
//  Created by Мах on 17.11.2024.
//

import UIKit

class SingInViewController: UIViewController {
    
    let usernameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let confirmField = UITextField()
    
   
    private let signUpButton = UIButton.makePurpleButton(label: "SING UP", target: self, action: #selector(signUpButtonTapped))
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginGoogleButton = UIButton.makeWhiteButton(label: "Login with Google", target: self, action: #selector(googleButtonTapped))
    
      
    
    
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        
        
        
    }
    
    
    // MARK: - UI Setup
    
    func setupUI() {
//MARK: - TextField
        
        usernameField.configureTextField(placeholder: "Full name", icon: UIImage(named:"Profile"))
        emailField.configureTextField(placeholder: "abc@email.com", icon: UIImage(named: "Mail"))
        passwordField.configurePasswordField(placeholder: "Your password")
        confirmField.configurePasswordField(placeholder: "Confirm password")
        
        
        let stackField = UIStackView(arrangedSubviews: [usernameField, emailField, passwordField, confirmField ])
        stackField.axis = .vertical
        stackField.spacing = 19
        stackField.translatesAutoresizingMaskIntoConstraints = false
                        
        view.addSubview(stackField)
        
        NSLayoutConstraint.activate([
            stackField.topAnchor.constraint(equalTo: view.topAnchor, constant: 146),
            stackField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            stackField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
        
//MARK: - Buttons
        
        let stackButton = UIStackView(arrangedSubviews: [signUpButton, loginGoogleButton])
        stackButton.axis = .vertical
        stackButton.spacing = 100
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackButton)
        
        NSLayoutConstraint.activate([
            stackButton.topAnchor.constraint(equalTo: stackField.bottomAnchor, constant: 50),
            stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
       
        ])
    }
    
    
    
    // MARK: - SignUp Method & Firebase
    
    @objc func signUpButtonTapped() {
        print("Sign Up button tapped!")
    }
    
    
    @objc func googleButtonTapped() {
        print("Google Up button tapped!")
        
    }
    
    // MARK: - UITextFieldDelegate
    
    
}


#Preview{SingInViewController()}
