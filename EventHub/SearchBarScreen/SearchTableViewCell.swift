//
//  SearchResultCell.swift
//  EventHub
//
//  Created by Валентина Попова on 27.11.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"

    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder_image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let eventDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата и время"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Название события"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AirbnbCereal_W_Bk", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Инициализация ячейки
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventDateAndTimeLabel)
        contentView.addSubview(eventNameLabel)
    }
    
    func configure(with event: Event) {
        eventNameLabel.text = event.formattedTitle
        
//        if let date = event.date {
//            eventDateAndTimeLabel.text = date.formattedDate()
//        } else {
//            eventDateAndTimeLabel.text = "Дата неизвестна"
//        }
        
        if let imageURL = event.images?.first?.image {
            eventImageView.loadImage(from: imageURL)
        } else {
            eventImageView.image = UIImage(named: "placeholder_image") // Замените на вашу картинку
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eventImageView.widthAnchor.constraint(equalToConstant: 70),
            eventImageView.heightAnchor.constraint(equalToConstant: 70),
            
            eventNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            eventNameLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            eventNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            eventDateAndTimeLabel.bottomAnchor.constraint(equalTo: eventNameLabel.topAnchor, constant: -5),
            eventDateAndTimeLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
            eventDateAndTimeLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor)
        ])
    }
}
