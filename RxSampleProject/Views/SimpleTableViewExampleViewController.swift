//
//  ViewController.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/19/25.
//

import UIKit
import RxCocoa
import RxSwift

final class SimpleTableViewExampleViewController: BaseViewController {
    private let tableView = {
        let tableView = UITableView()
        tableView.register(SimpleTableViewCell.self, forCellReuseIdentifier: SimpleTableViewCell.identifier)
        tableView.rowHeight = 52
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        self.title = "Simple table view"
        tableView.separatorStyle = .singleLine
    }
    
    
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showData() {
        items.bind(to: tableView.rx.items(cellIdentifier: "SimpleTableViewCell", cellType: SimpleTableViewCell.self)) {
            (row, element, cell) in
            cell.infoLabel.text = "\(element) @ row \(row)"
            cell.accessoryType = .detailButton

        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(with: self) { owner, value in
                owner.showAlert(title: "ReExample", message: "Tapped `\(value)`")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .bind(with: self, onNext: { owner, indexPath in
                owner.showAlert(title: "ReExample", message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)
    }
}

