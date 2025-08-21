//
//  SimpleValidationViewModel.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    struct Input {
        let username: ControlProperty<String>
        let password: ControlProperty<String>
        let buttonTap: ControlEvent<Void>
    }
    
    struct Output {
        let isUsernameValid: Observable<Bool>
        let isPasswordValid: Observable<Bool>
        let isEverythingValid: Observable<Bool>
        let buttonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let minimalUsernameLength = 5
        let minimalPasswordLength = 5

        let isUsernameValid = input.username
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        
        let isPasswordValid = input.password
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
            
        
        let isEverythingValid = Observable.combineLatest(isUsernameValid, isPasswordValid) { $0 && $1 }
            .share(replay: 1)
        
        let buttonTapped = input.buttonTap
        
        return Output(
            isUsernameValid: isUsernameValid,
            isPasswordValid: isPasswordValid,
            isEverythingValid: isEverythingValid,
            buttonTapped: buttonTapped
        )
    }
}
