//
//  TMTMenuButton.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import UIKit

class TMTMenuButton: UIButton {

    var title: String?
    var menuItem: MenuItem?
    
    init() {
        super.init(frame: .zero)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
        self.titleLabel?.adjustsFontForContentSizeCategory = true
        
        self.setTitleColor(.systemRed, for: .normal)
    }
}
