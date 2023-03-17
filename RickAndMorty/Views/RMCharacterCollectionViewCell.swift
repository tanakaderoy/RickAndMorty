//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Tanaka Mazivanhanga on 2/18/23.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    public static let cellIdentifier: String = String(describing: RMCharacterCollectionViewCell.self)
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.activateTamic()
        return label
    }()
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.activateTamic()
        return label
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode  = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.activateTamic()
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(imageView,nameLabel,statusLabel)
        contentView.backgroundColor = .secondarySystemFill
        self.roundCorners()
        addConstraints()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let horizontalConstant: CGFloat = 7
    private let labelHeight: CGFloat = 30
    private func addConstraints() {
        let constraints:[NSLayoutConstraint] = [
            statusLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: horizontalConstant),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -horizontalConstant),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: horizontalConstant),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -horizontalConstant),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,constant: -3),
            
        
        ]
//        imageView.fillInParent()
        NSLayoutConstraint.activate(constraints)
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel){
        Task {
            
            let image  = await viewModel.characterImage
           await updateImageView(image)
        }
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        
    }
    
    
    @MainActor
    func updateImageView(_ image:UIImage?) async{
        imageView.image = image
    }
    
    
    
}
