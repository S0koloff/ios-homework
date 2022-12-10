//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sokolov on 23.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var coordinator: FeedFlow?
    
    var viewModel: FeedViewModel?
    
    private lazy var checkGuessTextField: UITextField = {
        let checkGuessTextField = UITextField()
        checkGuessTextField.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        checkGuessTextField.layer.cornerRadius = 4
        checkGuessTextField.layer.borderWidth = 1
        checkGuessTextField.layer.borderColor = UIColor.gray.cgColor
        checkGuessTextField.placeholder = " Waiting for something..."
        checkGuessTextField.translatesAutoresizingMaskIntoConstraints = false
        return checkGuessTextField
    }()
    
    private lazy var checkGuessButton = CustomButton(title: "Check", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 4, useShadow: false, action: {self.buttonCheckGuessAction()})
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonPost = CustomButton(title: "Post", titleColor: .white, backgroundButtonColor: .systemBlue, cornerRadius: 4, useShadow: false, action: { self.buttonPostAction()})
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupView()
        self.addTapGestureToHideKeyboard()
    }
    
    private func setupView() {
        self.view.addSubview(self.buttonPost)
        self.view.addSubview(self.checkGuessTextField)
        self.view.addSubview(self.checkGuessButton)
        self.view.addSubview(self.label)
        
        self.buttonPost.isHidden = true
        
        NSLayoutConstraint.activate([
            self.checkGuessTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            self.checkGuessTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            self.checkGuessTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -25),
            self.checkGuessTextField.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 130),
            
            self.checkGuessButton.topAnchor.constraint(equalTo: self.checkGuessTextField.bottomAnchor, constant: 25),
            self.checkGuessButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25),
            self.checkGuessButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25),
            self.checkGuessButton.bottomAnchor.constraint(equalTo: self.checkGuessTextField.bottomAnchor, constant: 55),
            
            self.label.topAnchor.constraint(equalTo: self.checkGuessButton.bottomAnchor, constant: 25),
            self.label.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 25),
            self.label.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -25),
            self.label.bottomAnchor.constraint(equalTo: self.checkGuessButton.bottomAnchor,constant: 55),

            self.buttonPost.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 700),
            self.buttonPost.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 16),
            self.buttonPost.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            self.buttonPost.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -100)
        
        ])
    }
    
    func bindViewModel() {
        viewModel?.buttonCheckPressed(word: checkGuessTextField.text!)
        if viewModel?.correctWord == false {
            self.label.backgroundColor = .red
        } else {
            self.label.backgroundColor = .green
            self.buttonPost.isHidden = false
        }
        
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGesture() {
        checkGuessTextField.resignFirstResponder()
    }
    
    @objc private func buttonCheckGuessAction() {
        
        bindViewModel()
        
//        let checker = FeedModel()
//
//        if checker.checkWord(word: checkGuessTextField.text!) == false {
//            self.label.backgroundColor = .red
//        } else { self.label.backgroundColor = .green
//        }
    }
    
    
    @objc private func buttonPostAction() {
        coordinator?.coordinateToPost()
        
//        let postViewController = PostViewController()
//        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
