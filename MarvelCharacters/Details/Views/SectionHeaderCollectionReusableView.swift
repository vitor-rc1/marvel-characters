//
//  SectionCollectionReusableView.swift
//  MarvelCharacters
//
//  Created by Vitor Conceicao on 09/01/22.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    lazy var sectionHeader: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionHeader)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            sectionHeader.topAnchor.constraint(equalTo: topAnchor),
            sectionHeader.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            sectionHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
