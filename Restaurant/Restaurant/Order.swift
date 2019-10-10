//
//  Order.swift
//  Restaurant
//
//  Created by Muhammad Ashary on 10/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
