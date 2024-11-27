//
//  SearchResultCell.swift
//  EventHub
//
//  Created by Валентина Попова on 27.11.2024.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    private let backgroungCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 15
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let eventBackgroungView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image88")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let eventDateAndTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Wed,Apr 28 • 5:30 PM"
        label.textColor = .blueBackground
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jo Malone London's Mother's Day Presents"
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AirbnbCereal_W_Bk", size: 14) //.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let idTableViewCell = "idTableViewCell"
    
    private var eventLocationStaskView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(backgroungCell)
        backgroungCell.addSubview(eventBackgroungView)
        backgroungCell.addSubview(eventImageView)
        backgroungCell.addSubview(eventDateAndTimeLabel)
        backgroungCell.addSubview(eventNameLabel)
    }
    
    func configure(with event: Event) {
        eventNameLabel.text = event.formattedTitle
        if let date = event.nextDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, MMM d • h:mm a"
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date.start ?? 0)))
            eventDateAndTimeLabel.text = dateString
        } else {
            eventDateAndTimeLabel.text = "Дата не указана"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroungCell.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            backgroungCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backgroungCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            backgroungCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            eventBackgroungView.centerYAnchor.constraint(equalTo: backgroungCell.centerYAnchor),
            eventBackgroungView.leadingAnchor.constraint(equalTo: backgroungCell.leadingAnchor, constant: 10),
            eventBackgroungView.topAnchor.constraint(equalTo: backgroungCell.topAnchor, constant: 5),
            eventBackgroungView.bottomAnchor.constraint(equalTo: backgroungCell.bottomAnchor, constant: -5),
            eventBackgroungView.widthAnchor.constraint(equalToConstant: 70),
            
            eventImageView.topAnchor.constraint(equalTo: eventBackgroungView.topAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: eventBackgroungView.bottomAnchor),
            
            eventDateAndTimeLabel.topAnchor.constraint(equalTo: backgroungCell.topAnchor, constant: 8),
            eventDateAndTimeLabel.leadingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: 10),
            eventDateAndTimeLabel.trailingAnchor.constraint(equalTo: backgroungCell.trailingAnchor, constant: -10),
            
            eventNameLabel.topAnchor.constraint(equalTo: eventDateAndTimeLabel.bottomAnchor, constant: 3),
            eventNameLabel.leadingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor,constant: 10),
            eventNameLabel.widthAnchor.constraint(equalToConstant: 100),
            eventNameLabel.trailingAnchor.constraint(equalTo: backgroungCell.trailingAnchor, constant: -10)
        ])
    }
}
