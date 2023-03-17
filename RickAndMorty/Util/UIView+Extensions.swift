//
//  UIView+Extensions.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit

extension UIView {
    func activateTamic() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: UIView...){
        views.forEach({
            self.addSubview($0)
        })
    }
    
    func fitInParentLayoutGuide(parentView: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            rightAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),
            leftAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leftAnchor),
        ]
    }
    func fillInParent(){
        self.activateTamic()
        guard let superview = superview else {return}
        NSLayoutConstraint.activate( [
            topAnchor.constraint(equalTo: superview.topAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
        ])
    }
    
    func roundCorners() {
        if let self = self as? UICollectionViewCell {
            self.contentView.layer.cornerRadius = 8
            self.contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
            self.contentView.layer.cornerRadius = 4
            self.contentView.layer.shadowOffset = .init(width: -4, height: 4)
            self.contentView.layer.shadowOpacity = 0.3

        }
        self.layer.cornerRadius = 8
    }
    
    func centerInParent(_ constant: CGFloat = 100) {
        guard let superview = self.superview else{return}
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: constant),
           self.heightAnchor.constraint(equalToConstant: constant),
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
       ])
    }
}
