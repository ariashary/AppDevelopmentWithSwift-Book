//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by Muhammad Ashary on 10/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import Foundation

struct Categories: Codable {
    let categories: [String]
}

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
