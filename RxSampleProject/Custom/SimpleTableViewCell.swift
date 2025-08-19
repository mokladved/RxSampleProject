//
//  SimpleTableViewCell.swift
//  RxSampleProject
//
//  Created by Youngjun Kim on 8/19/25.
//

import UIKit
import SnapKit

final class SimpleTableViewCell: UITableViewCell {
    
    static let identifier = "SimpleTableViewCell"
    
    let infoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let infoButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.clipsToBounds = true
        return button
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
    
    
    
    override func layoutSubviews() {
        infoButton.layer.cornerRadius = infoButton.frame.height / 2
    }
}

extension SimpleTableViewCell: UIConfigurable {
    func configureHierarchy() {
        contentView.addSubview(infoLabel)
        contentView.addSubview(infoButton)
    }
    
    func configureLayout() {
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .white
    }
}
