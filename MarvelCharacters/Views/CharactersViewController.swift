//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import UIKit
import SDWebImage

class CharactersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: CharactersViewModel!
    private var characters: [MarvelCharacter] = []
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersViewModel()
        self.view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        addComponents()
        addConstraints()
        
        loadCharacters(page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Characters"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        if (indexPath.row == characters.count - 1 ) {
            page += 1
            loadCharacters(page: page)
        }
        print(indexPath.row)
        let character = characters[indexPath.row]
        let url = URL(string: character.thumbnail.url)
        cell.characterName.text = character.name
        cell.characterImage.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private func addComponents() {
//        self.view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func loadCharacters(page: Int) {
        viewModel.fetchCharacters(page: page) { characters in
            self.characters.append(contentsOf: characters)
            print(characters.count)
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
}
