//
//  GetFeed.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 28/5/21.
//

import Foundation
import SwiftyJSON

struct FeedService {
    
    func get(for feedUrl: FeedURL, completion: @escaping(Result<[Article]?, Error>) -> Void) {
        var articles: [Article]?
        
        let url = feedUrl.getURL
        
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                let json = JSON(data)
                let items = json["items"]
                let itemsData = try? items.rawData()
                
                if let itemsData = itemsData {
                    let decoder = try! JSONDecoder().decode([Article].self, from: itemsData)
                    articles = decoder.filter({ $0.title != nil && $0.title!.count > 0})
                    completion(.success(articles))
                } else {
                    completion(.failure(error ?? NSError()))
                }
            } else {
                completion(.failure(error ?? NSError()))
            }
        }
        task.resume()
    }
}
