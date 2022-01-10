//
//  FavoritesViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 04/01/22.
//

import UIKit
import CoreData

class FavoritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let storage = CoreDataStorage.shared
    private var characters: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favorites"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        addComponents()
        addConstraints()
        
        loadCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadCharacters()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        let character = characters[indexPath.row]
        let id = character.value(forKey: "id") as! Int
        let name = character.value(forKey: "name") as! String
        let image = character.value(forKey: "img") as! Data
        
        cell.characterName.text = name
        cell.characterImage.image = UIImage(data: image)
        cell.characterId = id
        cell.isCharacterFavorite = true
        cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {let character = characters[indexPath.row]
        let id = character.value(forKey: "id") as! Int
        let characterDetailsVC = CharacterDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        characterDetailsVC.characterId = id
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width/2.0) - 5.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    private func addComponents() {
//        self.view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 20),
        ])
    }
    
    private func loadCharacters() {
        characters = storage.getCharacters()
        collectionView.reloadData()
    }
    
}
