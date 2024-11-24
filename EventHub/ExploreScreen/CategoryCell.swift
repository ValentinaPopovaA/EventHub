//
//  CategoryCell.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCereal_W_Bk", size: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 6
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: Category, isSelected: Bool) {
        titleLabel.text = category.name
        contentView.backgroundColor = category.color
        iconImageView.image = UIImage(systemName: category.sfSymbol)
        setSelected(isSelected)
    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            titleLabel.textColor = .black
            iconImageView.tintColor = .black
            contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(0.9)
        } else {
            titleLabel.textColor = .white
            iconImageView.tintColor = .white
            contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(1.0)
        }
    }
}
