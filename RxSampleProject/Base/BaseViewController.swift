//
//  BaseViewController.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/20/25.
//

import UIKit

class BaseViewController: UIViewController, UIConfigurable {
    
    override func viewDidLoad() {
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
