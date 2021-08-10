//
//  ArticlesByCategoryViewModel.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 7/6/21.
//

import Foundation

struct ArticlesByCategoryViewModel {
    
    var menuItem: MenuItem?
    
    var feedUrl: FeedURL? {
        guard let menuItem = menuItem else { return nil }
        
        switch menuItem {
        case .world:
            return .world
        case .politics:
            return .politics
        case .money:
            return .money
        case .health:
            return .health
        case .entertainment:
            return .entertainment
        case .environment:
            return .environment
        case .tech:
            return .tech
        case .sports:
            return .sports
        }
    }
    
}
