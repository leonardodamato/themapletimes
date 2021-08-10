//
//  SectionTitleCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 31/5/21.
//

import UIKit

class SectionTitleCell: UITableViewCell {

    var titleLabel: UILabel!
    var lineView: UIView!
    
    override func prepareForReuse() {
        titleLabel.removeFromSuperview()
        lineView.removeFromSuperview()
    }
    
    func configure(with title: String) {
        self.selectionStyle = .none
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        titleLabel.adjustsFontForContentSizeCategory = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.edgePadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.edgePadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.edgePadding),
        ])
        
        lineView = UIView()
        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemRed
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.edgePadding),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.edgePadding),
            lineView.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
}
