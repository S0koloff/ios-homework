//
//  LogInViewController.swift
//  Navigation
//
//  Created by Sokolov on 08.09.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import SwiftEntryKit
import RealmSwift


class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    var factory = MyLoginFactory()
    
    var bruteForce = GeneratePassAndBruteForce()
    
    let concurrentQueue = DispatchQueue(label: "App.cuncurrent", qos: .userInteractive, attributes: [.concurrent])
    
    var realm = try! Realm()
    
    var service = Service()
    
    var profileDate: ProfileDate?


    var timer: Timer?
    
    var timeOfBrute = 0

//#if DEBUG
//        var userService = TestUserService()
//#else
//        var userService = CurrentUserService()
//#endif
    
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
    
    private lazy var timeToBrute: UILabel = {
        let timeToBrute = UILabel()
        timeToBrute.font = UIFont.systemFont(ofSize: 13)
        timeToBrute.tintColor = .systemGray6
        timeToBrute.translatesAutoresizingMaskIntoConstraints = false
        return timeToBrute
    }()
    
    private lazy var regLabel: UILabel = {
        let regLabel = UILabel()
        regLabel.font = UIFont.systemFont(ofSize: 13)
        regLabel.translatesAutoresizingMaskIntoConstraints = false
        regLabel.text = "If you don't have an account, you can"
        return regLabel
    }()
    
    private lazy var regButton: UIButton = {
        let regButton = UIButton()
        regButton.setTitle("register", for: .normal)
        regButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        regButton.setTitleColor(.systemBlue, for: .normal)
        regButton.addTarget(self, action: #selector(self.regButtonAction), for: .touchUpInside)
        regButton.translatesAutoresizingMaskIntoConstraints = false
        return regButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBarController?.tabBar.isHidden = true
        
        checkAuthorization()
        
        realm.objects(ProfileDate.self)
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        setupGesture()
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.textFieldsStackView)
        self.scrollView.addSubview(self.logoImageView)
        self.scrollView.addSubview(self.editButton)
        self.scrollView.addSubview(self.generateButton)
        self.scrollView.addSubview(self.activityInticator)
        self.scrollView.addSubview(self.timeToBrute)
        self.scrollView.addSubview(self.regLabel)
        self.scrollView.addSubview(self.regButton)
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
            
            self.timeToBrute.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.timeToBrute.bottomAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: -15),
            
            self.activityInticator.bottomAnchor.constraint(equalTo: self.generateButton.topAnchor, constant: -20),
            self.activityInticator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.generateButton.topAnchor.constraint(equalTo: self.regLabel.bottomAnchor, constant: 16),
            self.generateButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.generateButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -16),
            self.generateButton.bottomAnchor.constraint(equalTo: self.generateButton.topAnchor, constant: 36),
            
            self.logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.116144),
            self.logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.241546),
            
            self.editButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16),
            self.editButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.editButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.editButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.058072),
            
            self.regLabel.topAnchor.constraint(equalTo: self.editButton.bottomAnchor, constant: 16),

            self.regLabel.bottomAnchor.constraint(equalTo: self.regLabel.topAnchor, constant: 16),
            self.regLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -24),
            
            self.regButton.topAnchor.constraint(equalTo: self.editButton.bottomAnchor, constant: 16),
            self.regButton.leftAnchor.constraint(equalTo: self.regLabel.rightAnchor,constant: 5),
            self.regButton.bottomAnchor.constraint(equalTo: self.regButton.topAnchor, constant: 16),
            
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
        self.passwordTextField.text = ""
        
    }
    
    func checkAuthorization() {
        
        let profileAuth = realm.objects(ProfileDate.self)
        
        print("login:", profileAuth.first?.login as Any)
        print("password", profileAuth.first?.password as Any)

        if profileAuth.contains(where: { $0.authorization == true}) {
            
            self.loginTextField.text = profileAuth.first?.login
            self.passwordTextField.text = profileAuth.first?.password
            
            buttonAction()
            
        } else {
            print("Error check")
        }
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
        timeToBrute.isHidden = true
        self.scrollView.setContentOffset(.zero, animated: true)
    
    }
    
    func setupRegistrationPopUpView() -> EKFormMessageView {
        
        let title = EKProperty.LabelContent(text: "Registration", style: .init(font: UIFont.systemFont(ofSize: 20), color: .black))
        
        let email = EKProperty.LabelContent(text: "Email...", style: .init(font: UIFont.systemFont(ofSize: 13), color: .init(red: 208, green: 208, blue: 208)))
        let pass = EKProperty.LabelContent(text:"Password...", style: .init(font: UIFont.systemFont(ofSize: 13), color: .init(red: 208, green: 208, blue: 208)))
        
        var emailTextField = EKProperty.TextFieldContent(placeholder: email, textStyle: .init(font: UIFont.systemFont(ofSize: 15), color: .black), leadingImage: UIImage(systemName: "person"))
        
        emailTextField.textContent = self.loginTextField.text ?? ""
        
        var passTextField = EKProperty.TextFieldContent(placeholder: pass, textStyle: .init(font: UIFont.systemFont(ofSize: 15), color: .black), leadingImage: UIImage(systemName: "key"))
        
        passTextField.textContent = self.passwordTextField.text ?? ""
        passTextField.isSecure = true

        let buttonLabel = EKProperty.LabelContent(text: "Sign Up", style: .init(font: UIFont.systemFont(ofSize: 17), color: .white))
                
        let button = EKProperty.ButtonContent(label: buttonLabel, backgroundColor: .init(red: 71, green: 134, blue: 204), highlightedBackgroundColor: .clear) {
            
            if emailTextField.textContent.isValidEmail == false {
                print("Email error")
            } else {
                if passTextField.textContent.isValidPass == false {
                    print("Pass error")
                } else {
                    
                    self.service.createProfile(login: emailTextField.textContent, password: passTextField.textContent, authorization: true)
                    
                    let checkerService = CheckerService()
                    checkerService.signUp(for: emailTextField.textContent, and: passTextField.textContent) { result in
                        switch result {
                        case .success(let user):
                            let profileViewController = ProfileViewController(user: user)
                            self.navigationController?.pushViewController(profileViewController, animated: true)
                            SwiftEntryKit.dismiss()
                        case .failure(let error):
                            print("Error of registration", error)
                        }
                    }
                }
            }
        }
        
        let message = EKFormMessageView(with: title, textFieldsContent: [emailTextField, passTextField], buttonContent: button)
        
        return message
    }
    
    private func registrationAllert() {
        SwiftEntryKit.display(entry: setupRegistrationPopUpView(), using: setupAttributesForRegistration())
    }
        
    @objc private func buttonAction() {
        
        let checkerService = CheckerService()

        checkerService.checkCredentials(for: loginTextField.text!, and: passwordTextField.text!) { result in
            switch result {
            case .success(let user):
                let profileViewController = ProfileViewController(user: user)
                self.navigationController?.pushViewController(profileViewController, animated: true)
            case .failure(let error):
                let alert = UIAlertController(title: "User not found!", message: "Please, registration a new account or enter correct date", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Close", style: .cancel))

                let signUp = UIAlertAction(title: "Sign Up", style: .default) { _ in
                    
                    self.registrationAllert()
                }
                
                alert.addAction(signUp)
                self.present(alert, animated: true)
                print("Error of date",error)
            }
        }

    }
        
        
//        if factory.makeLoginInspector().check(log: loginTextField.text!, pass: passwordTextField.text!) == .success(true) {
//        if userService.checkService(login: loginTextField.text!) != nil {
//            let profileViewController = ProfileViewController(user: user)
//            self.navigationController?.pushViewController(profileViewController, animated: true)
//        } else {
//            let alert = UIAlertController(title: "Incorrect login", message: "Please, enter correct login", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Close", style: .cancel))
//            let signUp = UIAlertAction(title: "Sign Up", style: .default) { _ in
//            }
//            alert.addAction(signUp)
//            self.present(alert, animated: true)
//        }
//
//    }
    
    @objc private func regButtonAction() {
        registrationAllert()
    }
    
    private func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timeofBruteUpdate),
                                     userInfo: nil,
                                     repeats: true)
      }
    
    @objc private func generateButtonAction() {
        createTimer()
        activityInticator.startAnimating()
        
        concurrentQueue.async { [self] in
            
        let generatedPassword = bruteForce.randomPass()
        
            bruteForce.bruteForce(passwordToUnlock: generatedPassword)
            
            DispatchQueue.main.async { [self] in
                passwordTextField.text = generatedPassword
                passwordTextField.isSecureTextEntry = false
                activityInticator.stopAnimating()
                cancelTimer()
                timeToBrute.text = "\(timeOfBrute)s to brute password"
                timeToBrute.isHidden = false
            }
        }
        
        timerofBruteReload()
    }

    
    @objc private func timeofBruteUpdate() {
        timeOfBrute += 1
    }
    
    @objc private func timerofBruteReload() {
        if timeOfBrute != 0 {
            timeOfBrute = 0
        }
    }
    
    private func cancelTimer() {
      timer?.invalidate()
    }
    
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var isValidPass: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[A-Za-z\\d]{6,}$").evaluate(with: self)
    }
}

