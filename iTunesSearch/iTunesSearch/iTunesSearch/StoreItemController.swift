//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Muhammad Ashary on 10/10/19.
//  Copyright © 2019 Caleb Hicks. All rights reserved.
//

import UIKit

class StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/search?")!
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any],
                let resultsArray = json["results"] as? [[String: Any]] {
                
                let storeItems = resultsArray.map { StoreItem(json: $0) }
                completion(storeItems as? [StoreItem])
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
                return
            }
        }
        task.resume()
    }
    
    func fetchItemArtwork(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data){
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
