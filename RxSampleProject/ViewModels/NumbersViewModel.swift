//
//  NumbersViewModel.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/22/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NumbersViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let firstNumber: ControlProperty<String>
        let secondNumber: ControlProperty<String>
        let thirdNumber: ControlProperty<String>
    }

    struct Output {
        let result: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let combinedValues = Observable.combineLatest(input.firstNumber, input.secondNumber, input.thirdNumber)
        
        let result = combinedValues
            .map { text1, text2, text3 -> Int in
                return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
            }
            .map { "\($0)" }
        
        return Output(result: result)
    }
}
