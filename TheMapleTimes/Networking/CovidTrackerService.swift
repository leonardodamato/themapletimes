//
//  CovidTrackerService.swift
//  TheMapleTimes
//
//  Created by Leonardo D'Amato on 4/6/21.
//

import Foundation
import SwiftyJSON

struct CovidTrackerService {
    func getCovidNumbers(completion: @escaping (Result<CovidTracker?, Error>) -> Void) {
        let url = URL(string: "https://covid-19.dataflowkit.com/v1/canada")!
        
        let session = URLSession(configuration: .default, delegate: .none, delegateQueue: .main)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else
            
            if let data = data {
                let json = JSON(data)
                
                let confirmedCases = json["Total Cases_text"].stringValue
                let numberOfDeaths = json["Total Deaths_text"].stringValue

                let tracker = CovidTracker(confirmedCases: confirmedCases, numberOfDeaths: numberOfDeaths)
                completion(.success(tracker))
            }
        }
        
        task.resume()
    }
}
