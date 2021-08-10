//
//  ArticlesByCategoryViewController.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 7/6/21.
//

import UIKit
import SafariServices

class ArticlesByCategoryViewController: UIViewController {

    var menuItem: MenuItem
    
    var feedUrl: FeedURL? {
        didSet {
            if let feedUrl = feedUrl {
                getFeed(feedUrl: feedUrl)
            }
        }
    }
    
    var articles: [Article]? {
        didSet {
            if let _ = articles {
                self.tableView.reloadData()
            }
        }
    }
    
    var tableView: UITableView! 
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - View Lifeclycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        getFeedURL()
        configureTableView()
        
    }
    
    //MARK: - UI Configuration
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
        
        tableView.register(SectionTitleCell.self, forCellReuseIdentifier: "SectionTitleCell")
        tableView.register(MainStoryCell.self, forCellReuseIdentifier: "MainStoryCell")
        tableView.register(SmallStoryCell.self, forCellReuseIdentifier: "SmallStoryCell")
        tableView.register(CovidTrackerCell.self, forCellReuseIdentifier: "CovidTrackerCell")

        
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
    
    //MARK: - Actions
    
    func getFeedURL() {
        let viewModel = ArticlesByCategoryViewModel(menuItem: menuItem)
        
        if let _ = viewModel.menuItem {
            feedUrl = viewModel.feedUrl
        }
    }
    
    func getFeed(feedUrl: FeedURL) {
        let feedService = FeedService()
        
        feedService.get(for: feedUrl) { (result) in
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                //TODO: - Print error to user
                print(error.localizedDescription)
            }
        }
    }
}


//MARK: - TableView Delegate and Data Source 
extension ArticlesByCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArticlesByCategoryViewControllerTableViewSections.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ArticlesByCategoryViewControllerTableViewSections(rawValue: section) else {
               return 0
           }
        
        guard let articles = articles else { return 0 }

        switch section {
        case .title:
            return 1
        case .mainStory:
            return 1
        case .secondaryStory:
            return articles.count - 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ArticlesByCategoryViewControllerTableViewSections(rawValue: indexPath.section)
        let row = indexPath.row
        guard let articles = articles else { return UITableViewCell() }
        
        switch section {
                case .title:
                    let titleCell = tableView.dequeueReusableCell(withIdentifier: "SectionTitleCell", for: indexPath) as! SectionTitleCell
                    titleCell.configure(with: menuItem.rawValue)
                    return titleCell
                    
                case .mainStory:
                    let mainStoryCell = tableView.dequeueReusableCell(withIdentifier: "MainStoryCell", for: indexPath) as! MainStoryCell
                    mainStoryCell.configure(article: articles[row])
                    return mainStoryCell
                    
                case .secondaryStory:
                    let smallStoryCell = tableView.dequeueReusableCell(withIdentifier: "SmallStoryCell", for: indexPath) as! SmallStoryCell
                    smallStoryCell.configure(with: articles[row + 1])
                    return smallStoryCell
//                case .footer:
//                    return 1
       default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = ArticlesByCategoryViewControllerTableViewSections(rawValue: indexPath.section)
        
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
            
        default:
            break
        }
    }
}

enum ArticlesByCategoryViewControllerTableViewSections: Int, CaseIterable {
    case title
    case mainStory
    case secondaryStory
}
