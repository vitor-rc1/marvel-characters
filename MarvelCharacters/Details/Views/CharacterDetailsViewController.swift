//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 08/01/22.
//

import UIKit

class CharacterDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: CharactersDetailsViewModel!
    private var comics: [MarvelCharacterMidia] = []
    private var series: [MarvelCharacterMidia] = []
    var character: MarvelCharacter?
    var characterStorage: CharacterStorage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharactersDetailsViewModel()
        
        self.view.backgroundColor = .white
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CharacterDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "descriptionCell")
        collectionView.register(SectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        
        
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
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionCollectionReusableView
            headerView.sectionHeader.text = indexPath.section == 1 ? "Comics" : "Series"
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCell", for: indexPath) as! CharacterDetailsCollectionViewCell
            if let character = character  {
                cell.buildCell(character)
            } else if let characterStorage = characterStorage {
                cell.buildCell(characterStorage)
            }
            return cell
        } else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
            
            let comic = comics[indexPath.row]
            cell.buildCell(comic)
            return cell
        } else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
            
            let serie = series[indexPath.row]
            cell.buildCell(serie)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.width)
        }
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
    
    private func loadCharacterDetails() {
        var characterId: Int
        
        if let character = character {
            characterId = character.id
        } else if let characterStorage = characterStorage {
            characterId = Int(truncating: characterStorage.id as NSNumber)
        } else {
            return
        }

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
    
}
