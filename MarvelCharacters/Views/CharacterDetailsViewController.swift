//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 08/01/22.
//

import UIKit

class CharacterDetailsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var viewModel: CharactersDetailsViewModel!
    private var character: [String: Any]?
    private var comics: [[String: Any]] = []
    private var series: [[String: Any]] = []
    var characterId: Int!
    
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
        if section == 0 {
            return CGSize.zero
        }
        let size = CGSize(width: view.frame.width, height: 50)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! SectionCollectionReusableView
            if indexPath.section == 1 {
                headerView.sectionHeader.text = "Comics"
            } else if indexPath.section == 2 {
                headerView.sectionHeader.text = "Series"
            }
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
            
            let comic = comics[indexPath.row]
            let title = comic["title"] as! String
            let urlString = comic["url"] as! String
            let url = URL(string: urlString)
            
            cell.characterName.text = title
            cell.characterImage.sd_setImage(with: url, completed: nil)
            cell.favoriteButton.isHidden = true
            return cell
        } else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell
            
            let serie = series[indexPath.row]
            let title = serie["title"] as! String
            let urlString = serie["url"] as! String
            let url = URL(string: urlString)
            
            cell.characterName.text = title
            cell.characterImage.sd_setImage(with: url, completed: nil)
            cell.favoriteButton.isHidden = true
            return cell
        } else if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "descriptionCell", for: indexPath) as! CharacterDetailsCollectionViewCell
            guard let character = character else {
                return cell
            }

            var description = character["description"] as! String
            if description.isEmpty {
                description = "Sem descrição."
            }
            let urlString = character["url"] as! String
            let url = URL(string: urlString)
            
            cell.characterImage.sd_setImage(with: url, completed: nil)
            cell.characterDescription.text = description
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
        viewModel.fetchCharacter(id: characterId) { character in
            self.character = character
            DispatchQueue.main.sync {
                let name = character["name"] as! String
                self.title = name
                self.collectionView.reloadData()
            }
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
