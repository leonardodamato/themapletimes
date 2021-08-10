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

    var menuItem: MenuItem?
    var menuItemDidTap: (()->())?
    
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
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.Constraints.edgePadding),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
        ])
    }
    
    
    func configureStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        let menuItems = MenuItem.allCases
        
        for item in menuItems {
            let button = TMTMenuButton(title: item.rawValue)
            button.menuItem = item
            button.addTarget(self, action: #selector(menuButtonDidTap(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
         
        return stackView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
         }
    }
    
    @objc func menuButtonDidTap(_ sender: TMTMenuButton) {
        self.menuItem = sender.menuItem
        menuItemDidTap?()
    }
}
