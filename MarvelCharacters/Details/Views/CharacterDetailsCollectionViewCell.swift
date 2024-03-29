//
//  CharacterDetailsCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 09/01/22.
//

import UIKit

class CharacterDetailsCollectionViewCell: UICollectionViewCell {
    var characterId: Int!
    var characterName: String!
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "default-image")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var characterDescription: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addComponents()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell(_ character: MarvelCharacter) {
        characterId = character.id
        characterName = character.name
        characterDescription.text = character.verifiedDescription
        let thumbUrl = URL(string: character.thumbnail.url)
        characterImage.sd_setImage(with: thumbUrl, completed: nil)
    }
    
    func buildCell(_ character: CharacterStorage) {
        guard let img = character.img else {
            return
        }
        characterId =  Int(truncating: character.id as NSNumber)
        characterName = character.name
        characterDescription.text = character.charDescription
        characterImage.image = UIImage(data: img)
    }
    
    private func addComponents() {
        contentView.addSubview(characterImage)
        contentView.addSubview(characterDescription)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 200),
            characterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            characterDescription.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10),
            characterDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

