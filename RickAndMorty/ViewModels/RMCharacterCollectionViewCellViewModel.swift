//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit
import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public let characterName:String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
    
    
    init(characterName: String, characterImageURL: URL?, characterStatus: RMCharacterStatus) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageURL = characterImageURL
    }
    
    public var characterStatusText:String {
        return "Status: \(characterStatus.text)"
    }
    
    public var characterImage: UIImage? {
        get async {
            return await RMImageManager.shared.fetchImage(url: characterImageURL)
        }
    }
    
    
}



