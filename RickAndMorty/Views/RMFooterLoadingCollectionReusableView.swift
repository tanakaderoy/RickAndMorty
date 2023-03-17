//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 3/2/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = String(describing: RMFooterLoadingCollectionReusableView.self)
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.activateTamic()
        return spinner
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        spinner.centerInParent()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints() {
        
    }
    
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
