//
//  TabViewController.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/11/23.
//

import UIKit
import Foundation

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
