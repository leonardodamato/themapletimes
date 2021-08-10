//
//  HomeViewController.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    let feed = Feed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        feed.get(for: .canada) { (result) in
            switch result {
                case .success(let articles):
                    for article in articles! {
                        print(article.title ?? "Error")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
