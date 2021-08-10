//
//  FooterCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 4/8/21.
//

import UIKit

class FooterCell: UITableViewCell {

    var titleLabel: UILabel!
    
    func configure() {
        contentView.backgroundColor = .systemRed
        configureTitleLabel()
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .white
        titleLabel.text = "The Maple Times. Created by Leonardo D'Amato"
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
