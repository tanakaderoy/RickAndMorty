//
//  RMTabBarController.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import UIKit

final class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTabs()
    }
    
    
    private func setupTabs() {
        let characterVC  = RMCharacterViewController(image: "person")
        let settingsVC  = RMSettingsViewController(image: "gear")
        let locationsVC  = RMLocationViewController(image: "globe")
        let episodesVC  = RMEpisodeViewController(image: "tv")
        print(characterVC.image)
        
        let navControllers = [characterVC,locationsVC,episodesVC,settingsVC].enumerated().map { (index,vc) in
            vc.view.backgroundColor = .systemBackground
            vc.navigationItem.largeTitleDisplayMode = .automatic
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: vc.title, image: UIImage(systemName: vc.image), tag: index)
            nav.navigationBar.prefersLargeTitles = true
            return nav
            
        }
        
        setViewControllers(navControllers, animated: true)
        
    }


}




class TabViewController: UIViewController {
    var image: String
    
    init(image:String){
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
