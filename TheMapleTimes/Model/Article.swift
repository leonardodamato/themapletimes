//
//  Article.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import Foundation

struct Article: Codable {
    var title: String?
    var content: String?
    var author: String?
    var categories: [String]?
    var pubDate: String?
    var thumbnail: String?
    var link: String?
}
