//
//  Headers.swift
//  SportsApp
//
//  Created by Sarah Ahmed on 25/05/2024.
//

import Foundation

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeaderView"
    let textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 22)
        ])
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    

}

