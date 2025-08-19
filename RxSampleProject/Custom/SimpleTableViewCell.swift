//
//  SimpleTableViewCell.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/19/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewCell: UITableViewCell {
    
    static let identifier = "SimpleTableViewCell"
    
    let infoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension SimpleTableViewCell: UIConfigurable {
    func configureHierarchy() {
        contentView.addSubview(infoLabel)

    }
    
    func configureLayout() {
        infoLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureView() {
        
    }
}
