//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit
import Foundation

protocol RMCharacterListViewViewModelDelegate:AnyObject {
    func didLoadInitialCharacters()
    func didSelectCharacter(_ charachter:RMCharacter)
    func didLoadAdditionalCharacters(with newIndexPaths: [IndexPath])
}

final class RMCharacterListViewViewModel: NSObject {
    
    public weak var delegate: RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters: Bool = false
    
    private var characters:[RMCharacter] = [] {
        didSet {
            for character in characters {
                let cellViewModel:RMCharacterCollectionViewCellViewModel = .init(characterName: character.name, characterImageURL: URL(string:(character.image)), characterStatus: character.status)
                if !cellViewModels.contains(cellViewModel){
                    cellViewModels.append(cellViewModel)
                }
            }
            
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    public func fetchInitialCharacters() async {
        let res = await RMService.getAllCharacters()
        switch res {
        case .success(let (chars, info)):
            self.characters = chars
            self.apiInfo = info
            await MainActor.run {
                delegate?.didLoadInitialCharacters()
            }
        case .failure(let error):
            print(error)
        }
    }
    
    public func fetchNextCharacters() async {
        guard !isLoadingMoreCharacters else {return}
        isLoadingMoreCharacters = true
        guard let urlString = apiInfo?.next else {return}
        let res = await RMService.getPagenatedCharacters(urlString: urlString)
        
        switch res {
        case .success(let (chars, info)):
            let originalCount = characters.count
            self.characters.append(contentsOf: chars)
            self.apiInfo = info
            
            await MainActor.run {
                let indexPaths: [IndexPath] = getIndexPaths(originalCount: originalCount, newCount: chars.count)
                delegate?.didLoadAdditionalCharacters(with: indexPaths )
            }
            
        case .failure(let error):
            print(error)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { [weak self] in
            self?.isLoadingMoreCharacters = false
        }
    }
    
    public var shouldShowLoadMoreIndicator:Bool {
        return apiInfo?.next != nil
    }
    
    
    private func getIndexPaths(originalCount: Int, newCount: Int) -> [IndexPath] {
        let total = originalCount + newCount
        let startingIndex = total - newCount
        let indexPaths:[IndexPath] = Array(startingIndex..<(startingIndex + newCount)).compactMap({return IndexPath(row: $0, section: 0)})
        return indexPaths
    }
    
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {fatalError("Unsupported Cell")}
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    
    
}

extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath) as?
                RMFooterLoadingCollectionReusableView else {fatalError("Unsupported")}
        footer.startAnimating()
        
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else{return .zero}
        return CGSize(width:collectionView.frame.width, height: 100)
    }
    
}

extension RMCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator ,!cellViewModels.isEmpty, !isLoadingMoreCharacters else {return}
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        
        if offset >= (totalContentHeight - frameHeight - 120) {
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                Task {
                    await self?.fetchNextCharacters()
                    t.invalidate()
                    
                }
            }
            
            
            
            
            
        }
    }
}


