//
//  LoginViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let headerView = AuthHeaderView(title: "EventHub", subTitle: "Sign in")
    private let userDefaults = UserDefaults.standard
    private let emailKey = "SavedEmail"
    private let passwordKey = "SavedPassword"
    
    let emailField = UITextField()
    let passwordField = UITextField()
    
    private let rememberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont(name: "AirbnbCereal_W_Bk", size: 14)
        label.text = "Remember Me "
        return label
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dontLabel: UILabel = {
        let label = UILabel()
        label.text = "Don’t have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.onTintColor = .blueForButtonExplore
        toggle.thumbTintColor = .white
        toggle.backgroundColor = .systemGray4
        toggle.layer.cornerRadius = 16
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    private let stackField: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 19
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stackButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let downStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    private let forgotButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let signUpButton = CustomButton(title: "Sign up", isBlue: true, fontSize: .small)
    
    private let signInButton = UIButton.makePurpleButton(label: "SING IN", target: self, action: #selector(signInButtonTapped))
    
    private let loginGoogleButton = UIButton.makeWhiteButton(label: "Login with Google", target: self, action: #selector(googleButtonTapped))
 
    
    // MARK: - LifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.view.backgroundColor = .systemBackground
        
        self.forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        toggleSwitch.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        toggleSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        autoFillField()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
  
        emailField.configureTextField(placeholder: "abc@email.com", icon: UIImage(named: "Mail"))
        passwordField.configurePasswordField(placeholder: "Your password")
        
        self.view.addSubview(headerView)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackField.addArrangedSubview(emailField)
        stackField.addArrangedSubview(passwordField)

        horizontalStack.addArrangedSubview(toggleSwitch)
        horizontalStack.addArrangedSubview(rememberLabel)
        horizontalStack.addArrangedSubview(forgotButton)
        
        stackButton.addArrangedSubview(signInButton)
        stackButton.addArrangedSubview(orLabel)
        stackButton.addArrangedSubview(loginGoogleButton)
        
        downStack.addArrangedSubview(dontLabel)
        downStack.addArrangedSubview(signUpButton)

        
        view.addSubview(stackField)
        view.addSubview(horizontalStack)
        view.addSubview(stackButton)
        view.addSubview(downStack)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            stackField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 130),
            stackField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            horizontalStack.topAnchor.constraint(equalTo: stackField.bottomAnchor, constant: 20),
            horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            stackButton.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 20),
            stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            downStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    //MARK: - Selectors
    
    @objc func signInButtonTapped() {
        print("Sign In button tapped!")
        
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.singIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
                
            }
            
        }
    }
    
    

    @objc func googleButtonTapped() {
        print("Google button tapped!")
        //        let webView = WebViewerController(with: "https://www.google.ru/")
        //        let nav = UINavigationController(rootViewController: webView)
        //        self.present(nav, animated: true, completion: nil)
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let _ = result, error == nil else {return}

          guard let user = result?.user,
                let idToken = user.idToken?.tokenString else {return}
            self?.signInWithGoogle(idToken: idToken, accessToken: user.accessToken.tokenString)
          
        }
    }
    
    func signInWithGoogle(idToken: String, accessToken: String ) {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { result, error in
            guard let _ = result, error == nil else {return}
            self.openVC()
        }
    }
    
    private func openVC() {
        let vc = TabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func forgotButtonTapped() {
        print("forgotButton tapped!")
        let vc = RessetViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        print("Sign Up Button tapped!")
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }

    @objc private func didChangeSwitch() {
        if toggleSwitch.isOn {
            guard let email = emailField.text, !email.isEmpty,
                  let password = passwordField.text, !password.isEmpty else { return }
            
            userDefaults.set(email, forKey: emailKey)
            userDefaults.set(password, forKey: passwordKey)
            print("Debug Test", "saved email, pass")
        } else {
            userDefaults.removeObject(forKey: emailKey)
            userDefaults.removeObject(forKey: passwordKey)
            print("Debug Test", "delete email, pass")
        }
    }
    
    //MARK: - автозаполнение при входе
    
    private func autoFillField() {
        if let savedEmail = userDefaults.string(forKey: emailKey),
           let savedPass = userDefaults.string(forKey: passwordKey) {
            emailField.text = savedEmail
            passwordField.text = savedPass
            toggleSwitch.isOn = true
        } else {
            toggleSwitch.isOn = false
        }
        
    }
    
    
}

//#Preview{ LoginViewController()}
