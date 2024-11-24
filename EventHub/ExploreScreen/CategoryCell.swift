//
//  CategoryCell.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCereal_W_Bk", size: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    func configure(with category: Category) {
        titleLabel.text = category.name
        contentView.backgroundColor = category.color
    }
}
