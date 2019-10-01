//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Muhammad Ashary on 01/10/19.
//  Copyright © 2019 M. Ashary. All rights reserved.
//

import Foundation

struct Emoji {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
