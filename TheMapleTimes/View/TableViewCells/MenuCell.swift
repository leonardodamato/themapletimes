//
//  MenuCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import UIKit

class MenuCell: UITableViewCell, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var container: UIView!
    
    var stackView: UIStackView!

    
    override func prepareForReuse() {
        stackView.removeFromSuperview()
        scrollView.removeFromSuperview()
    }
    
    func configure() {
        scrollView = UIScrollView()
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        container = UIView()
        scrollView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        stackView = configureStackView()
        container.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
        ])
    }
    
    
    func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        let menuItems = MenuItems.allCases
        
        for item in menuItems {
            let button = TMTMenuButton(title: item.rawValue)
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
         }
    }
}
