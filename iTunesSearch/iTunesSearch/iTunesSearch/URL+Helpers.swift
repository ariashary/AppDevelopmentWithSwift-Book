//
//  URL+Helpers.swift
//  iTunesSearch
//
//  Created by Muhammad Ashary on 10/10/19.
//  Copyright © 2019 Caleb Hicks. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
