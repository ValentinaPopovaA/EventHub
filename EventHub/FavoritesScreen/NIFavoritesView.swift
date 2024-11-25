//
//  NIFavoritesView.swift
//  EventHub
//
//  Created by apple on 11/24/24.
//

import UIKit

class NoFavoritesView: UIView {
    
    private let noFavoritesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector")
        imageView.contentMode = .bottomRight
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let vectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector-2")
        imageView.contentMode = .bottomRight
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let vectorSecondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector-3")
        imageView.contentMode = .bottomRight
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private let noFavoritesEventLabel: UILabel = {
        let label = UILabel()
        label.text = "NO VAFORITES"
        label.font = UIFont(name: "AirbnbCereal_W_Bd", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(noFavoritesEventLabel)
        addSubview(noFavoritesImageView)
        addSubview(vectorImageView)
        addSubview(vectorSecondImageView)
    }
}

extension NoFavoritesView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            noFavoritesEventLabel.topAnchor.constraint(equalTo: topAnchor),
            noFavoritesEventLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            noFavoritesImageView.topAnchor.constraint(equalTo:noFavoritesEventLabel.bottomAnchor, constant: 60),
            noFavoritesImageView.heightAnchor.constraint(equalToConstant: 145),
            noFavoritesImageView.widthAnchor.constraint(equalToConstant: 140),
            noFavoritesImageView.centerXAnchor.constraint(equalTo: noFavoritesEventLabel.centerXAnchor),
            
            vectorImageView.topAnchor.constraint(equalTo: noFavoritesEventLabel.bottomAnchor,constant: 90),
            vectorImageView.centerXAnchor.constraint(equalTo: noFavoritesImageView.centerXAnchor),
            vectorImageView.heightAnchor.constraint(equalToConstant: 35),
            vectorImageView.widthAnchor.constraint(equalToConstant: 35),
            
            vectorSecondImageView.topAnchor.constraint(equalTo: noFavoritesEventLabel.bottomAnchor, constant: 90),
            vectorSecondImageView.centerXAnchor.constraint(equalTo: noFavoritesImageView.centerXAnchor),
            vectorSecondImageView.heightAnchor.constraint(equalToConstant: 35),
            vectorSecondImageView.widthAnchor.constraint(equalToConstant: 35),
        ])
    }
}

