//
//  EventsViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit
import Foundation

class EventsViewController: UIViewController {
    
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.text = "Events"
        label.font = .airbnbCerealWBd24()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    private let segmentedControl = CustomSegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
    
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
    
    private let exploreEventsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("EXPLORE EVENTS", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "arrow.right.circle.fill"))
        arrowImageView.tintColor = .white // Цвет стрелки
        
        arrowImageView.backgroundColor = .blue
        arrowImageView.layer.cornerRadius = 20
        arrowImageView.clipsToBounds = true
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFit
        
        button.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            arrowImageView.widthAnchor.constraint(equalToConstant: 40),
            arrowImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstrainst()
        
        for family in UIFont.familyNames {
            print("\(family)")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("  \(name)")
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(eventsLabel)
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noEventsImageView)
        view.addSubview(noUpcomingEventLabel)
        view.addSubview(noUpcomDescriptionLabel)
        view.addSubview(exploreEventsButton)
        
    }
    
    @objc private func segmentedChange() {
        
    }
}

extension EventsViewController {
    
    private func setConstrainst() {
        NSLayoutConstraint.activate([
            eventsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            eventsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 22),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            noEventsImageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 100),
            noEventsImageView.heightAnchor.constraint(equalToConstant: 200),
            noEventsImageView.widthAnchor.constraint(equalToConstant: 200),
            noEventsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            noUpcomingEventLabel.topAnchor.constraint(equalTo: noEventsImageView.bottomAnchor, constant: 15),
            noUpcomingEventLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            noUpcomDescriptionLabel.topAnchor.constraint(equalTo: noUpcomingEventLabel.bottomAnchor, constant: 15),
            noUpcomDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exploreEventsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -128),
            exploreEventsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -48),
            exploreEventsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            exploreEventsButton.heightAnchor.constraint(equalToConstant: 58)
            
        ])
        
    }
}
