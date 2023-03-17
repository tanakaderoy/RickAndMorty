//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    let results: [RMCharacter]
    let info: Info
    
    struct Info: Codable {
        let count: Int
        let pages:Int
        let next: String?
        let prev: String?
    }
    
}
