//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import UIKit
import SDWebImage
import CoreData

class CharactersViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var viewModel: CharactersViewModel!
    private var characters: [MarvelCharacter] = []
    private var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersViewModel()
        viewModel.onErrorHandling = errorHandling
        
        self.view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        addComponents()
        addConstraints()
        loadCharacters(page: page)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func errorHandling(message: String) {
        let controller = UIAlertController(title: "An error occured", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
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
        
        let character = characters[indexPath.row]
        cell.buildCell(character)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let characterDetailsVC = CharacterDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        characterDetailsVC.character = character
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widhtCell = (collectionView.bounds.width/2.0) - 5.0
        let heightCell = widhtCell
        
        return CGSize(width: widhtCell, height: heightCell)
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
    
    private func loadCharacters(page: Int) {
        
        viewModel.fetchCharacters(page: page) { characters in
            self.characters.append(contentsOf: characters)
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
}
