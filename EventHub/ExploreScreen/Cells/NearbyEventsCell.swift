//
//  NearbyEventsCell.swift
//  EventHub
//
//  Created by Екатерина Орлова on 26.11.2024.
//

import UIKit

class NearbyEventsCell: UICollectionViewCell {
    
    static let identifire = "NearbyEventsCell"
    private let eventService = EventService()
    
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
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"image 84")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .redAccent
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateMonthLabel: UILabel = {
        let label = UILabel()
        label.text = "JUN"
        label.textColor = .redAccent
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bookmark_white"), for: .normal)
        button.setImage(UIImage(named: "Bookmark_red"), for: .selected)
        button.backgroundColor = .lightGray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "International Band Mu..."
        label.textColor = .titleColor
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let peopleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"people")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 20 Going"
        label.textColor = .blueForButtonExplore
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"Map_pin")
//        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "36 Guild Street London, UK "
        label.textColor = .subColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: Event) {
        if let imageUrl = event.images?.first?.image {
            imageView.loadImage(from: imageUrl)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
        
        nameLabel.text = event.title.capitalized
        
        numbersLabel.text = "+\(event.favoritesCount ?? 0) Going"
        
        locationLabel.text = "Loading address..."
        
        if let place = event.place, let placeID = place.id {
            eventService.fetchPlaceDetails(placeID: placeID) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedPlace):
                        let placeTitle = fetchedPlace.title ?? "Unknown Place"
                        let cityName = fetchedPlace.location.flatMap { fetchedPlace.cityName(for: $0) } ?? ""
                        
                        self?.locationLabel.text = cityName.isEmpty ? placeTitle : "\(placeTitle), \(cityName)"
                    case .failure(let error):
                        print("Failed to fetch place details: \(error)")
                        self?.locationLabel.text = "Unknown Location"
                    }
                }
            }
        } else {
            locationLabel.text = "Unknown Location"
        }
        
        if let nextDate = event.nextDate {
            dateLabel.text = nextDate.start?.formattedDateComponent() ?? "N/A"
            dateMonthLabel.text = nextDate.start?.formattedMonth() ?? ""
        } else {
            dateLabel.text = "N/A"
            dateMonthLabel.text = ""
        }
        
        if let favoritesCount = event.favoritesCount {
            numbersLabel.text = "+ \(favoritesCount) Going"
        } else {
            numbersLabel.text = "+ 0 Going"
        }

         saveButton.isUserInteractionEnabled = true
     }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func setupUI() {
        addSubview(backgroungCell)
        backgroungCell.addSubview(eventBackgroungView)
        
        eventBackgroungView.addSubview(imageView)
        eventBackgroungView.addSubview(saveButton)
        eventBackgroungView.addSubview(dateView)
        
        eventBackgroungView.addSubview(nameLabel)
        eventBackgroungView.addSubview(peopleImageView)
        eventBackgroungView.addSubview(numbersLabel)
        eventBackgroungView.addSubview(locationImageView)
        eventBackgroungView.addSubview(locationLabel)
        
        dateView.addSubview(dateLabel)
        dateView.addSubview(dateMonthLabel)
    }
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            backgroungCell.topAnchor.constraint(equalTo: topAnchor),
            backgroungCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroungCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroungCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            eventBackgroungView.topAnchor.constraint(equalTo: backgroungCell.topAnchor),
            eventBackgroungView.leadingAnchor.constraint(equalTo: backgroungCell.leadingAnchor),
            eventBackgroungView.trailingAnchor.constraint(equalTo: backgroungCell.trailingAnchor),
            eventBackgroungView.bottomAnchor.constraint(equalTo: backgroungCell.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: eventBackgroungView.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 131),
            
            saveButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            saveButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 30),
            
            dateView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            dateView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            dateView.widthAnchor.constraint(equalToConstant: 45),
            dateView.heightAnchor.constraint(equalToConstant: 45),
            
            dateLabel.topAnchor.constraint(equalTo: dateView.topAnchor, constant: 4),
            dateLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            
            dateMonthLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2),
            dateMonthLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            peopleImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 14),
            peopleImageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 10),
            
            numbersLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 19),
            numbersLabel.leadingAnchor.constraint(equalTo: peopleImageView.trailingAnchor, constant: 10),
            
            locationImageView.topAnchor.constraint(equalTo: peopleImageView.bottomAnchor, constant: 14),
            locationImageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 10),

            locationLabel.topAnchor.constraint(equalTo: locationImageView.topAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 10)
        ])
    }
}
