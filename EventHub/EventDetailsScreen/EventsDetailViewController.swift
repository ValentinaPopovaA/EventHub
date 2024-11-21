//
//  EventsDetailViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eventsDetail")
        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bookmark_white"), for: .normal)

        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveToFavorites), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "share icon"), for: .normal)
        button.addTarget(self, action: #selector(sharePressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35)
        label.text = "International Band Music Concert"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayForDetail
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var dateIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Calendar_blue")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "14 December, 2021"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Tuesday, 4:00PM - 9:00PM"
        label.textColor = .subColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let locationView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayForDetail
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var locationIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Location")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Gala Convention Center"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var adressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "36 Guild Street London, UK"
        label.textColor = .subColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var photoIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image 70")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Ashfak Sayem"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var organizerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Organizer"
        label.textColor = .subColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var aboutEventsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "About Event"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More...Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More..."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
       makeConstraits()
    }
    
    @objc private func saveToFavorites() {
        
    }
    
    @objc private func sharePressedButton() {
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
       
        imageView.addSubview(saveButton)
        imageView.addSubview(shareButton)
        view.addSubview(scrollView)
        scrollView.addSubview(eventLabel)
        
        scrollView.addSubview(dateView)
        dateView.addSubview(dateIcon)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(timeLabel)
        
        scrollView.addSubview(locationView)
        locationView.addSubview(locationIcon)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(adressLabel)
        
        scrollView.addSubview(photoIcon)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(organizerLabel)
        scrollView.addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(aboutEventsLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        
    }
    
    private func makeConstraits() {
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 244),
        
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -10),
            saveButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -12),
            saveButton.heightAnchor.constraint(equalToConstant: 36),
            saveButton.widthAnchor.constraint(equalToConstant: 36),
            
            shareButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            shareButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
            shareButton.heightAnchor.constraint(equalToConstant: 36),
            shareButton.widthAnchor.constraint(equalToConstant: 36),
                       
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            eventLabel.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor, constant: 50),
            eventLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            eventLabel.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 20),
            
            dateView.topAnchor.constraint(equalToSystemSpacingBelow: eventLabel.bottomAnchor, multiplier: 2),
            dateView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 20),
            dateView.heightAnchor.constraint(equalToConstant: 48),
            dateView.widthAnchor.constraint(equalToConstant: 48),
            
            dateIcon.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            dateIcon.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: eventLabel.bottomAnchor, multiplier: 2),
            dateLabel.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            timeLabel.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 1),
            timeLabel.leadingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            locationView.topAnchor.constraint(equalToSystemSpacingBelow: dateView.bottomAnchor, multiplier: 2),
            locationView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 20),
            locationView.heightAnchor.constraint(equalToConstant: 48),
            locationView.widthAnchor.constraint(equalToConstant: 48),
            
            locationIcon.centerYAnchor.constraint(equalTo: locationView.centerYAnchor),
            locationIcon.centerXAnchor.constraint(equalTo: locationView.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 24),
            locationLabel.leadingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            adressLabel.topAnchor.constraint(equalToSystemSpacingBelow: locationLabel.bottomAnchor, multiplier: 1),
            adressLabel.leadingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: 10),
            adressLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            photoIcon.topAnchor.constraint(equalToSystemSpacingBelow: locationView.bottomAnchor, multiplier: 2),
            photoIcon.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 20),
            photoIcon.heightAnchor.constraint(equalToConstant: 48),
            photoIcon.widthAnchor.constraint(equalToConstant: 48),
            
            nameLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: photoIcon.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            organizerLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1),
            organizerLabel.leadingAnchor.constraint(equalTo: photoIcon.trailingAnchor, constant: 10),
            organizerLabel.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            
            descriptionStackView.topAnchor.constraint(equalTo: photoIcon.bottomAnchor, constant: 24),
            descriptionStackView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: -20),
            descriptionStackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
        ])
    }
}
