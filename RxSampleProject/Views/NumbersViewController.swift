//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NumbersViewController: BaseViewController {

    private let wrappedView = UIView()
    
    private let firstTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        return textField
    }()
    
    private let secondTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        return textField
    }()
    
    private let thirdTextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        return textField
    }()
    
    private let plusSignLabel = {
        let label = UILabel()
        label.text = "+"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let separatorLine = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let resultLabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .right
        return label
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    

    override func configureHierarchy() {
        view.addSubview(wrappedView)
        wrappedView.addSubview(firstTextField)
        wrappedView.addSubview(secondTextField)
        wrappedView.addSubview(thirdTextField)
        wrappedView.addSubview(plusSignLabel)
        wrappedView.addSubview(separatorLine)
        wrappedView.addSubview(resultLabel)
    }

    override func configureLayout() {
        wrappedView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        firstTextField.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(100)
        }
        
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(firstTextField.snp.bottom).offset(12)
            make.width.trailing.equalTo(firstTextField)
        }
        
        thirdTextField.snp.makeConstraints { make in
            make.top.equalTo(secondTextField.snp.bottom).offset(12)
            make.width.trailing.equalTo(firstTextField)
        }
        
        plusSignLabel.snp.makeConstraints { make in
            make.centerY.equalTo(thirdTextField)
            make.trailing.equalTo(thirdTextField.snp.leading).offset(-12)
            make.leading.equalToSuperview()

        }
        
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(thirdTextField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(thirdTextField)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(12)
            make.leading.trailing.equalTo(separatorLine)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        super.configureView()
        self.title = "Adding numbers"
        firstTextField.text = "1"
        secondTextField.text = "2"
        thirdTextField.text = "3"
    }

    private func bind() {
        Observable.combineLatest(firstTextField.rx.text.orEmpty, secondTextField.rx.text.orEmpty, thirdTextField.rx.text.orEmpty)
            .map { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { "\($0)" }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
