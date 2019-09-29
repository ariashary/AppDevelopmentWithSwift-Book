//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Muhammad Ashary on 28/09/19.
//

import Foundation

struct Athlete {
    let name: String
    let age: Int
    let league: String
    let team: String
    
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)."
    }
}
