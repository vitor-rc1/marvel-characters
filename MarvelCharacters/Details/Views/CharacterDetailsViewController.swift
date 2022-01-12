//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 08/01/22.
//

import UIKit

class CharacterDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let storage = CoreDataStorage.shared
    private var viewModel: CharactersDetailsViewModel!
    private var comics: [MarvelCharacterMidia] = []
    private var series: [MarvelCharacterMidia] = []
    var character: MarvelCharacter?
    var characterStorage: CharacterStorage?
    var isFavorite: Bool = false
    var descriptionCell: CharacterDetailsCollectionViewCell!
    
    lazy var favoriteButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.imageView?.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favorite), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    lazy var favoritedButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.imageView?.tintColor = .systemYellow
        button.addTarget(self, action: #selector(favorite), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersDetailsViewModel()
        
        self.view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CharacterDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "descriptionCell")
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        
        
        addConstraints()
        loadCharacterDetails()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return comics.count
        } else if section == 2 {
            return series.count
        }
        
        return 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 0 ? CGSize.zero : CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionHeaderCollectionReusableView
            headerView.sectionHeader.text = indexPath.section == 1 ? "Comics" : "Series"
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        
        if indexPath.section == 0 {
            let descriptionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCell", for: indexPath) as! CharacterDetailsCollectionViewCell
            if let character = character  {
                descriptionCell.buildCell(character)
            } else if let characterStorage = characterStorage {
                descriptionCell.buildCell(characterStorage)
            }
            self.descriptionCell = descriptionCell
            return descriptionCell
        } else if indexPath.section == 1{
            let comic = comics[indexPath.row]
            cell.buildCell(comic)
        } else if indexPath.section == 2{
            let serie = series[indexPath.row]
            cell.buildCell(serie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        }
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
    
    private func loadCharacterDetails() {
        var characterId: Int
        
        if let character = character {
            characterId = character.id
            self.title = character.name
        } else if let characterStorage = characterStorage {
            characterId = Int(truncating: characterStorage.id as NSNumber)
            self.title = characterStorage.name
        } else {
            return
        }
        
        isFavorite = storage.checkFavoriteCharacter(id: characterId)
        self.navigationItem.rightBarButtonItem = isFavorite ? favoritedButton : favoriteButton
        
        viewModel.fetchCharacterMidias(id: characterId, specification: "comics") { comics in
            self.comics = comics
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.fetchCharacterMidias(id: characterId, specification: "series") { series in
            self.series = series
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 20),
        ])
    }
    
    @objc private func favorite() {
        guard
            let id = descriptionCell.characterId,
            let name = descriptionCell.characterName,
            let image = descriptionCell.characterImage.image?.pngData(),
            let descriptionText = descriptionCell.characterDescription.text
        else {
            return
        }
        
        if !isFavorite {
            storage.saveCharacter(name: name, id: id, image: image, descriptionText: descriptionText)
            self.navigationItem.rightBarButtonItem = favoritedButton
            isFavorite = true
        } else {
            storage.removeCharacter(id: id)
            self.navigationItem.rightBarButtonItem = favoriteButton
            isFavorite = false
        }
    }
    
}
