//
//  MainStoryCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 31/5/21.
//

import UIKit
import SDWebImage

class MainStoryCell: UITableViewCell {

    var stackView: UIStackView!
    
    var articleImage: UIImageView!
    var titleLabel: UILabel!
    var authorAndDateLabel: UILabel!
    
    var categoryStackView: UIStackView!
    var categoryLabel: UILabel!
    var shareButton: UIButton!
    
    
    override func prepareForReuse() {
        stackView.removeFromSuperview()
    }
    
    
    func configure(article: Article) {
        self.selectionStyle = .none
        
        configureStackView()
        configureArticleImage(article: article)
        if let categories = article.categories {
            configureCategory(category: categories.first ?? "")
            configureCategoryStackView()
        }
        configureTitle(article: article)
        
        configureAuthorAndDate(article: article)
        
        configureArrangedSubviews()
    }
    
    func configureStackView() {
        stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.edgePadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.edgePadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.edgePadding),
        ])
    }
    
    
    func configureArticleImage(article: Article) {
        articleImage = UIImageView()
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        
        articleImage.contentMode = .scaleToFill
        articleImage.backgroundColor = .systemGray6
        
        articleImage.sd_setImage(with: URL(string: article.thumbnail ?? ""), completed: nil)
        
        NSLayoutConstraint.activate([
            articleImage.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    func configureCategory(category: String) {
        categoryLabel = UILabel()
        categoryLabel.font = .preferredFont(forTextStyle: .caption1)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.textColor = .systemRed
        categoryLabel.text = category.uppercased()
    }
    
    func configureShareButton() {
        shareButton = UIButton()
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemRed
        
        NSLayoutConstraint.activate([
            shareButton.heightAnchor.constraint(equalToConstant: 16),
            shareButton.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func configureCategoryStackView() {
        categoryStackView = UIStackView()
        categoryStackView.axis = .horizontal
        categoryStackView.alignment = .fill
        categoryStackView.distribution = .fill
        categoryStackView.spacing = 20
        
        categoryStackView.addArrangedSubview(categoryLabel)
    }
    
    func configureTitle(article: Article) {
        titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = article.title ?? ""
        titleLabel.numberOfLines = 0
    }
    
    
    func configureAuthorAndDate(article: Article) {
        authorAndDateLabel = UILabel()
        authorAndDateLabel.font = .preferredFont(forTextStyle: .caption1)
        authorAndDateLabel.adjustsFontForContentSizeCategory = true
        authorAndDateLabel.textColor = .systemGray
       
        //TODO: - Format date (format: "21 jan 2021 | 03:57")
        authorAndDateLabel.text = "\(article.author ?? "Unknown Author") | \(article.pubDate ?? "Unknown Date")"
    }
    
    
    func configureArrangedSubviews() {
        stackView.addArrangedSubview(articleImage)
        //stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(categoryStackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorAndDateLabel)
    }
}
