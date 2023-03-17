//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter)
}

final class RMCharacterListView: UIView {
    
    private let viewModel = RMCharacterListViewViewModel()
    
    var delegate:RMCharacterListViewDelegate?
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.activateTamic()
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.activateTamic()
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateTamic()
        addSubviews(collectionView,spinner)
        
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        Task {
            await viewModel.fetchInitialCharacters()
            
        }
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    private func addConstraints() {
        
    
        
       collectionView.fillInParent()
        spinner.centerInParent()
    }
    
}


extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didLoadInitialCharacters() {
        collectionView.reloadData()
        spinner.stopAnimating()
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }

    func didSelectCharacter(_ charachter: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: charachter)
    }
    
    func didLoadAdditionalCharacters(with indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.insertItems(at: indexPaths)
        }
    }
}
