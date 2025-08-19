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

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: BaseViewController {
    
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
        button.backgroundColor = .green
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
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
        
        usernameStateLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordStateLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
    }
    
    
    private func bind() {
        
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordStateLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        everythingValid
            .map { $0 ? 1.0 : 0.5 }
            .bind(to: doSomethingButton.rx.alpha)
            .disposed(by: disposeBag)
        
        everythingValid
            .map { $0 ? UIColor.black : UIColor.white }
            .bind(with: self, onNext: { owner, color in
                owner.doSomethingButton.setTitleColor(color, for: .normal)
            })
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .bind(with: self) { owner, value in
                owner.showAlert(title: "RxExample", message: "This is wonderful")
            }
            .disposed(by: disposeBag)
    }
}
