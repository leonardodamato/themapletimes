//
//  SmallStoryCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 1/6/21.
//

import UIKit
import SDWebImage

class SmallStoryCell: UITableViewCell {

    var mainStackView: UIStackView!
    var textStackView: UIStackView!
    
    var articleImage: UIImageView!
    var articleCategory: UILabel!
    var articleTitle: UILabel!
    var articleAuthorAndDate: UILabel!
    
    
    override func prepareForReuse() {
        mainStackView.removeFromSuperview()
    }
    
    
    func configure(with article: Article) {
        self.selectionStyle = .none
        
        configureMainStackView()
        configureArticleImageView(article: article)
        configureTextStackView()
        configureCategoryText(article: article)
        configureTitleText(article: article)
        configureAuthorAndDate(article: article)
    }
    
    
    func configureMainStackView() {
        mainStackView = UIStackView()
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.axis = .horizontal
        mainStackView.spacing = 10
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.edgePadding),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.edgePadding),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.edgePadding),
        ])
    }
    
    
    func configureArticleImageView(article: Article) {
        articleImage = UIImageView()
       
        articleImage.backgroundColor = .systemGray6
        
        articleImage.contentMode = .scaleToFill
        articleImage.sd_setImage(with: URL(string: article.thumbnail ?? ""), completed: nil)
        
        NSLayoutConstraint.activate([
            articleImage.widthAnchor.constraint(equalToConstant: 140),
            articleImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        mainStackView.addArrangedSubview(articleImage)
    }
    
    
    func configureTextStackView() {
        textStackView = UIStackView()
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(textStackView)
        
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.distribution = .fill
        textStackView.alignment = .fill

        mainStackView.addArrangedSubview(textStackView)
        
    }
    
    
    func configureCategoryText(article: Article) {
        articleCategory = UILabel()
        
        if let categories = article.categories {
            articleCategory.text = categories.first?.uppercased() ?? "UNKNOWN CATEGORY"
        } else {
            articleCategory.text = "UNKNOWN CATEGORY"
        }
        
        articleCategory.textColor = .systemRed
        articleCategory.font = UIFont.preferredFont(forTextStyle: .caption1)
        articleCategory.adjustsFontForContentSizeCategory = true
        
        textStackView.addArrangedSubview(articleCategory)
    }
    
    
    func configureTitleText(article: Article) {
        articleTitle = UILabel()
        
        articleTitle.text = article.title ?? "Error loading title"
        articleTitle.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
        articleTitle.adjustsFontForContentSizeCategory = true
        articleTitle.numberOfLines = 0
        
        textStackView.addArrangedSubview(articleTitle)
    }
    
    
    func configureAuthorAndDate(article: Article) {
        articleAuthorAndDate = UILabel()
        articleAuthorAndDate.font = UIFont.preferredFont(forTextStyle: .caption1)
        articleAuthorAndDate.adjustsFontForContentSizeCategory = true
        articleAuthorAndDate.textColor = .systemGray
       
        //TODO: - Format date (format: "21 jan 2021 | 03:57")
        articleAuthorAndDate.text = "\(article.author ?? "Unknown Author") | \(article.pubDate ?? "Unknown Date")"
        
        textStackView.addArrangedSubview(articleAuthorAndDate)
    }
}
