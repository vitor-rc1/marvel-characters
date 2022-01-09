//
//  CardCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 05/01/22.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    private let storage = CoreDataStorage.shared
    var characterId: Int!
    var isCharacterFavorite: Bool = false
    
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "default-image")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var characterName: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.imageView?.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favorite), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addComponents()
        addConstraints()
        setViewStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewStyle() {
        contentView.layer.borderColor = CGColor(red: 0.686, green: 0.686, blue: 0.686, alpha: 1)
        contentView.layer.borderWidth = 0.7
        contentView.layer.cornerRadius = 10
    }
    
    private func addComponents() {
        contentView.addSubview(characterImage)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(characterName)
        horizontalStackView.addArrangedSubview(favoriteButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            characterImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            characterImage.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            characterImage.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor, constant: -10),
            
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc private func favorite() {
        if !isCharacterFavorite {
            guard
                let name = characterName.text,
                let image = characterImage.image?.pngData()
            else {
                return
            }
            storage.saveCharacter(name: name, id: characterId, image: image)
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isCharacterFavorite = true
        } else {
            storage.removeCharacter(id: characterId)
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            isCharacterFavorite = false
        }
    }
}
