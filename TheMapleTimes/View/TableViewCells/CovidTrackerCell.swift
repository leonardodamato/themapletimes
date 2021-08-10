//
//  CovidTrackerCell.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 4/6/21.
//

import UIKit

class CovidTrackerCell: UITableViewCell {

    var triplePadding = Constants.Constraints.edgePadding * 3
    
    
    var container: UIView!
    
    var trackTitleLabel: UILabel!
    
    var confirmedCasesStackView: UIStackView!
    var confirmedCasesTitleLabel: UILabel!
    var confirmedCasesLabel: UILabel!

    var numberOfDeathsStackView: UIStackView!
    var numberOfDeathsTitleLabel: UILabel!
    var numberOfDeathsLabel: UILabel!
   
    var horizontalStackView: UIStackView!
    
    func configure(with covidTracker: CovidTracker) {
        self.selectionStyle = .none
        
        configureContainerView()
        configureTrackTitleLabel()
        configureConfirmedCases(with: covidTracker)
        configureNumberOfDeaths(with: covidTracker)
        configureHorizontalStackView()
    }
    
    func configureContainerView() {
        container = UIView()
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.layer.borderWidth = 6
        container.layer.borderColor = UIColor.systemRed.cgColor
        
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Constraints.edgePadding),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Constraints.edgePadding),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Constraints.edgePadding)
        ])
    }
    
    func configureTrackTitleLabel() {
        trackTitleLabel = UILabel()
        container.addSubview(trackTitleLabel)
        trackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        trackTitleLabel.text = "COVID-19 Tracker"
        trackTitleLabel.textColor = .systemRed
        trackTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2).bold()
        trackTitleLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            trackTitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: triplePadding),
            trackTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: triplePadding),
            trackTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -triplePadding),
        ])
    }
    
    func configureConfirmedCases(with covidTracker: CovidTracker) {
        
        ///Configure confirmedCases StackView
        ///
        confirmedCasesStackView = UIStackView()
        
        confirmedCasesStackView.axis = .vertical
        confirmedCasesStackView.alignment = .center
        confirmedCasesStackView.distribution = .fill
        
        
        ///Configure confirmedCasesTitleLabel
        ///
        confirmedCasesTitleLabel = UILabel()
        
        confirmedCasesTitleLabel.text = "Confirmed Cases"
        //confirmedCasesTitleLabel.textColor = .systemRed
        confirmedCasesTitleLabel.font = .preferredFont(forTextStyle: .body)
        confirmedCasesTitleLabel.textAlignment = .center
        
        confirmedCasesStackView.addArrangedSubview(confirmedCasesTitleLabel)
        
        
        ///Configure confirmedCasesLabel
        ///
        confirmedCasesLabel = UILabel()
        
        confirmedCasesLabel.text = covidTracker.confirmedCases
        confirmedCasesLabel.textColor = .systemRed
        confirmedCasesLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        confirmedCasesLabel.textAlignment = .center
        
        confirmedCasesStackView.addArrangedSubview(confirmedCasesLabel)
    }
    
    func configureNumberOfDeaths(with covidTracker: CovidTracker) {
        
        ///Configure confirmedCases StackView
        ///
        numberOfDeathsStackView = UIStackView()
        
        numberOfDeathsStackView.axis = .vertical
        numberOfDeathsStackView.alignment = .center
        numberOfDeathsStackView.distribution = .fill
        
        
        ///Configure confirmedCasesTitleLabel
        ///
        numberOfDeathsTitleLabel = UILabel()
        
        numberOfDeathsTitleLabel.text = "Number of Deaths"
        //numberOfDeathsTitleLabel.textColor = .systemRed
        numberOfDeathsTitleLabel.font = .preferredFont(forTextStyle: .body)
        numberOfDeathsTitleLabel.textAlignment = .center
        
        numberOfDeathsStackView.addArrangedSubview(numberOfDeathsTitleLabel)
        
        
        ///Configure confirmedCasesLabel
        ///
        numberOfDeathsLabel = UILabel()
        
        numberOfDeathsLabel.text = covidTracker.numberOfDeaths
        numberOfDeathsLabel.textColor = .systemRed
        numberOfDeathsLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()
        numberOfDeathsLabel.textAlignment = .center
        
        numberOfDeathsStackView.addArrangedSubview(numberOfDeathsLabel)
    }
    
    
    func configureHorizontalStackView() {
        horizontalStackView = UIStackView()
        container.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .fillEqually
        
        horizontalStackView.addArrangedSubview(confirmedCasesStackView)
        horizontalStackView.addArrangedSubview(numberOfDeathsStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: trackTitleLabel.bottomAnchor, constant: Constants.Constraints.edgePadding),
            horizontalStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.Constraints.edgePadding),
            horizontalStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.Constraints.edgePadding),
            horizontalStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -triplePadding)
        ])
    }
}
