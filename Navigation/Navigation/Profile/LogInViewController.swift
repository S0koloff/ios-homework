//
//  LogInViewController.swift
//  Navigation
//
//  Created by Sokolov on 08.09.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    var factory = MyLoginFactory()
    
    var bruteForce = GeneratePassAndBruteForce()
    
    let concurrentQueue = DispatchQueue(label: "App.cuncurrent", qos: .userInteractive, attributes: [.concurrent])

#if DEBUG
        var userService = TestUserService()
#else
        var userService = CurrentUserService()
#endif
    
    let logoImage = UIImage(named: "vklogo")
    
    private lazy var logoImageView: UIImageView = {
        let logoView = UIImageView()
        logoView.contentMode = .scaleAspectFill
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = logoImage
        return logoView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.becomeFirstResponder()
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email of phone"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        button.setTitle("Log In", for: UIControl.State.normal)
        button.setBackgroundImage(UIImage (named: "bluepixel"), for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var generateButton = CustomButton(title: "Generate Password", titleColor: .black, backgroundButtonColor: .systemBlue, cornerRadius: 10, useShadow: false, action: { self.generateButtonAction() })
    
    private lazy var activityInticator: UIActivityIndicatorView = {
        let activityInticator = UIActivityIndicatorView(style: .large)
        activityInticator.translatesAutoresizingMaskIntoConstraints = false
        return activityInticator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        
        setupGesture()
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.textFieldsStackView)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.editButton)
        self.scrollView.addSubview(self.generateButton)
        self.scrollView.addSubview(self.activityInticator)
        self.textFieldsStackView.addArrangedSubview(self.loginTextField)
        self.textFieldsStackView.addArrangedSubview(self.passwordTextField)
        
        NSLayoutConstraint.activate ([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                
            self.textFieldsStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.textFieldsStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.textFieldsStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120),
            self.textFieldsStackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.116144),
            
            self.activityInticator.bottomAnchor.constraint(equalTo: self.generateButton.topAnchor, constant: -20),
            self.activityInticator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.generateButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16),
            self.generateButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.generateButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -16),
            self.generateButton.bottomAnchor.constraint(equalTo: self.generateButton.topAnchor, constant: 36),
            
            self.logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.116144),
            self.logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.241546),
            
            self.editButton.topAnchor.constraint(equalTo: self.generateButton.bottomAnchor, constant: 16),
            self.editButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.editButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.editButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.058072)
            
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.kbSHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginTextField.becomeFirstResponder()
    }
    

    @objc private func kbShow(_ notification: Notification) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.editButton.frame.origin.y + self.editButton.frame.origin.y + self.editButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let offset = keyboardOriginY <= loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(kbSHide))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func kbSHide() {
        
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    
    }
        
    @objc private func buttonAction() {
    
        let user = userService.user
            
        if factory.makeLoginInspector().check(log: loginTextField.text!, pass: passwordTextField.text!) == true {
//        if userService.checkService(login: loginTextField.text!) != nil {
            let profileViewController = ProfileViewController(user: user)
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            let alert = UIAlertController(title: "Incorrect login", message: "Please, enter correct login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc private func generateButtonAction() {
        
        activityInticator.startAnimating()
        
        concurrentQueue.async { [self] in
            
            let generatedPassword = bruteForce.randomPass()
            bruteForce.bruteForce(passwordToUnlock: generatedPassword)
            
            DispatchQueue.main.async { [self] in
                passwordTextField.text = generatedPassword
                passwordTextField.isSecureTextEntry = false
                activityInticator.stopAnimating()
            }
        }
    }

}

