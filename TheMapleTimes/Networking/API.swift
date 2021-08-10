//
//  URLs.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import Foundation

enum FeedURL: String {
    case canada = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fcanada%2Ffeed%2F&"
    case world = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fworld%2Ffeed%2F&"
    case politics = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fpolitics%2Ffeed%2F&"
    case money = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fmoney%2Ffeed%2F&"
    case health = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fhealth%2Ffeed%2F&"
    case entertainment = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fentertainment%2Ffeed%2F&"
    case environment = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fenvironment%2Ffeed%2F&"
    case tech = "rss_url=https%3A%2F%2Fglobalnews.ca%2Ftech%2Ffeed%2F&"
    case sports = "rss_url=https%3A%2F%2Fglobalnews.ca%2Fsports%2Ffeed%2F&"
    
    
    var getURL: URL {
        let url = "\(API.rootURL)\(self.rawValue)\(API.apiKey)"
        return URL(string: url)!
    }
}

struct API {
    static let rootURL = "https://api.rss2json.com/v1/api.json?"
    static let apiKey = "api_key=xwecphii0vzyp2xjowkvsycvny5jpkltdewbknt8"
}
