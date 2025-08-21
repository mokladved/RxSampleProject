//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


final class SimpleValidationViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = SimpleValidationViewModel()
    
    private let usernameLabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let usernameTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let usernameStateLabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let passwordTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordStateLabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let doSomethingButton = {
        let button = UIButton()
        button.setTitle("Do Something", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .green.withAlphaComponent(0.5)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureHierarchy() {
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(usernameStateLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordStateLabel)
        view.addSubview(doSomethingButton)
    }
    
    override func configureLayout() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        usernameStateLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameTextField)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameStateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordStateLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(passwordTextField)
        }
        
        doSomethingButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStateLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
        self.title = "Simple Validation"
        usernameStateLabel.text = "Username has to be at least 5 characters"
        passwordStateLabel.text = "Password has to be at least 5 characters"
    }
    
    
    private func bind() {
        let input = SimpleValidationViewModel.Input(
            username: usernameTextField.rx.text.orEmpty,
            password: passwordTextField.rx.text.orEmpty,
            buttonTap: doSomethingButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
  
        output.isUsernameValid
            .bind(to: usernameStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.isUsernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isPasswordValid
            .bind(to: passwordStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
    
        output.isEverythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.buttonTapped
            .bind(with: self) { owner, _ in
                owner.showAlert(title: "RxExample", message: "This is wonderful")
            }
            .disposed(by: disposeBag)
        
        output.isEverythingValid
            .map { $0 ? .black : .white }
            .bind(with: self) { owner, color in
                owner.doSomethingButton.setTitleColor(color, for: .normal)
            }
            .disposed(by: disposeBag)
    }
}
