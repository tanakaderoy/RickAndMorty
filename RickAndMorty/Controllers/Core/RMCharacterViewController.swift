//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import UIKit

final class RMCharacterViewController:  TabViewController {

    private let characterListView = RMCharacterListView()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Characters"
        
        view.addSubview(characterListView)
        characterListView.delegate = self
        
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        // Do any additional setup after loading the view.
    }
    

}


extension RMCharacterViewController : RMCharacterListViewDelegate {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
//        open detail character screen
        let vm = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: vm)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
