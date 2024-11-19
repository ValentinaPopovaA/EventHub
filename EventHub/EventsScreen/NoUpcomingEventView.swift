//
//  NoUpcomingEventView.swift
//  EventHub
//
//  Created by apple on 11/18/24.
//

import UIKit

class NoUpcomingEventView: UIView {
    
    private let noEventsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "schedule")
        imageView.contentMode = .bottomRight
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let noUpcomingEventLabel: UILabel = {
        let label = UILabel()
        label.text = "No Upcoming Event"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noUpcomDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet,\nconsectetur "
        label.font =  .airbnbCerealWBd16()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [noUpcomingEventLabel,
                                                                noUpcomDescriptionLabel],
                                             axis: .vertical,
                                             spacinng: 15)
    
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
        addSubview(noEventsImageView)
        addSubview(stackView)
    }
}

extension NoUpcomingEventView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            noEventsImageView.topAnchor.constraint(equalTo: topAnchor),
            noEventsImageView.heightAnchor.constraint(equalToConstant: 200),
            noEventsImageView.widthAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: noEventsImageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

