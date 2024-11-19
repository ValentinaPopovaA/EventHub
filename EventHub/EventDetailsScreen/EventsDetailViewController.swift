//
//  EventsDetailViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import Foundation
import UIKit

class EventsDetailViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eventsDetail")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = .white
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
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var dateIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Calendar")
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let locationView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
    
    }
