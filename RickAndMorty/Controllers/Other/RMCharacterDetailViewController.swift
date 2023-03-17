//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 3/2/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {
    private let viewModel:RMCharacterDetailViewViewModel
    
    init(viewModel:RMCharacterDetailViewViewModel){
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        // Do any additional setup after loading the view.
    }
    



}
