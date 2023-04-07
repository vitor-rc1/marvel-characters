//
//  CharactersViewController.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 03/01/22.
//

import UIKit
import SDWebImage
import CoreData

class CharactersViewController: UIViewController {
    // MARK: - Private Properties

    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.itemSize = CGSize(width: (view.frame.width / 2) - 5, height: (view.frame.width / 2) - 5)
        return collectionViewFlowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    private var viewModel: CharactersViewModel

    // MARK: - Inits

    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCharactersCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CardCollectionViewCell

        if (indexPath.row == viewModel.getCharactersCount() - 1 ) {
            viewModel.getNextCharactersPage()
        }

        let character = viewModel.getCharacter(index: indexPath.row)
        cell.buildCell(character)

        return cell
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel.getCharacter(index: indexPath.row)
        let characterDetailsVC = CharacterDetailsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        characterDetailsVC.character = character
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}

extension CharactersViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        tabBarController?.navigationItem.title = "Characters"
    }
}

extension CharactersViewController: CharactersViewModelDelegate {
    func didLoadCharacters() {
        collectionView.reloadData()
    }

    func showError(message: String) {
        let controller = UIAlertController(title: "An error occured", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}
