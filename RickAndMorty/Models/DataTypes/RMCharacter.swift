//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import Foundation

// MARK: - RMCharacter

struct RMCharacter: Codable {
    let id: Int
    let status: RMCharacterStatus
    let name, species, type: String
    let gender: RMCharacterGender
    let origin, location: RMOrigin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive,.dead:
            return rawValue
        case .unknown:
            return "Unkown"
        }
    }
}

enum RMCharacterGender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}


