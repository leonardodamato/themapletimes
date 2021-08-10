//
//  HomeViewController.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {

    let feedService = FeedService()
    let covidTrackerService = CovidTrackerService()
    
    var articles: [Article]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var covidTracker: CovidTracker? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureTableView()
        getStories()
        getCovidTracker()
    }

    
    func getStories() {
        feedService.get(for: .canada) { (result) in
            switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    
    func getCovidTracker() {
        covidTrackerService.getCovidNumbers { (result) in
            switch result {
            case .success(let tracker):
                self.covidTracker = tracker
            case .failure(let error):
                //TODO: - Show error to user
                print(error.localizedDescription)
            }
        }
    }
    
    
    func configureUI() {
        ///Insert logo to navigation bar
        ///
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "tmt-logo")
        navigationItem.titleView = imageView

        view.backgroundColor = .systemBackground
    }
    
    
    func configureTableView() {
        tableView = UITableView() 
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.register(SectionTitleCell.self, forCellReuseIdentifier: "SectionTitleCell")
        tableView.register(MainStoryCell.self, forCellReuseIdentifier: "MainStoryCell")
        tableView.register(SmallStoryCell.self, forCellReuseIdentifier: "SmallStoryCell")
        tableView.register(CovidTrackerCell.self, forCellReuseIdentifier: "CovidTrackerCell")
        tableView.register(FooterCell.self, forCellReuseIdentifier: "FooterCell")

        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 45
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewControllerTableViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeViewControllerTableViewSections(rawValue: section) else {
               return 0
           }
        
        guard let articles = articles else { return 0 }

        switch section {
        case .menu:
            return 1
        case .title:
            return 1
        case .mainStory:
            return 1
        case .secondaryStory:
            return 3
        case .covidtracker:
            return 1
        case .tertiaryStory:
            return articles.count - 4
        case .footer:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = HomeViewControllerTableViewSections(rawValue: indexPath.section)
        let row = indexPath.row
        guard let articles = articles else { return UITableViewCell() }
        guard let covidTracker = covidTracker else { return UITableViewCell() }
        
        switch section {
                case .menu:
                    let menuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
                    menuCell.configure()
                    
                    menuCell.menuItemDidTap = { [unowned self ] in
                        if let menuItem = menuCell.menuItem {
                            let vc = ArticlesByCategoryViewController(menuItem: menuItem)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }
                    
                    return menuCell
                    
                case .title:
                    let titleCell = tableView.dequeueReusableCell(withIdentifier: "SectionTitleCell", for: indexPath) as! SectionTitleCell
                    titleCell.configure(with: "Top Stories")
                    return titleCell
                    
                case .mainStory:
                    let mainStoryCell = tableView.dequeueReusableCell(withIdentifier: "MainStoryCell", for: indexPath) as! MainStoryCell
                    mainStoryCell.configure(article: articles[row])
                    return mainStoryCell
                    
                case .secondaryStory:
                    let smallStoryCell = tableView.dequeueReusableCell(withIdentifier: "SmallStoryCell", for: indexPath) as! SmallStoryCell
                    smallStoryCell.configure(with: articles[row + 1])
                    return smallStoryCell
                    
                case .covidtracker:
                    let covidTrackerCell = tableView.dequeueReusableCell(withIdentifier: "CovidTrackerCell", for: indexPath) as! CovidTrackerCell
                    covidTrackerCell.configure(with: CovidTracker(confirmedCases: covidTracker.confirmedCases, numberOfDeaths: covidTracker.numberOfDeaths))
                    return covidTrackerCell
                case .tertiaryStory:
                    let smallStoryCell = tableView.dequeueReusableCell(withIdentifier: "SmallStoryCell", for: indexPath) as! SmallStoryCell
                    smallStoryCell.configure(with: articles[row + 4])
                    return smallStoryCell
                case .footer:
                    let footerCell = tableView.dequeueReusableCell(withIdentifier: "FooterCell", for: indexPath) as! FooterCell
                    footerCell.configure()
                    return footerCell
       default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = HomeViewControllerTableViewSections(rawValue: indexPath.section)
        
        switch section {
        case .mainStory:
            let article = articles![indexPath.row]
            if let link = article.link, let url = URL(string: link) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true, completion: nil)
            }
            
        case .secondaryStory:
            let article = articles![indexPath.row + 1]
            if let link = article.link, let url = URL(string: link) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true, completion: nil)
            }
            
        case .tertiaryStory:
            let article = articles![indexPath.row + 4]
            if let link = article.link, let url = URL(string: link) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}

enum HomeViewControllerTableViewSections: Int, CaseIterable {
    case menu
    case title
    case mainStory
    case secondaryStory
    case covidtracker
    case tertiaryStory
    case footer
}
