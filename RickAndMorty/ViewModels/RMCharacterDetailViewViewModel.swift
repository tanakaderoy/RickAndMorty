//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 3/2/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String {
        return character.name
    }
    
}
