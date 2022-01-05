//
//  CardCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 05/01/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "hulk")
        return imageView
    }()
    
    lazy var characterName: UILabel = {
        let label = UILabel()
        label.text = "Hulk"
        label.tintColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addComponents()
        addConstraints()
    }
    
    private func addComponents() {
        contentView.addSubview(characterImage)
        contentView.addSubview(characterName)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            characterName.topAnchor.constraint(equalTo: characterImage.bottomAnchor),
            characterName.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            characterName.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            characterName.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
