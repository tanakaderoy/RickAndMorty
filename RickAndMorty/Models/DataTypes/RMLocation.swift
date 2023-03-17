//
//  RMLocation.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import Foundation

// MARK: - Location
struct RMLocation: Codable {
        let id: Int
        let name:String
        let type:String
        let dimension:String
        let residents: [String]
        let url:String
        let created:String
      }
