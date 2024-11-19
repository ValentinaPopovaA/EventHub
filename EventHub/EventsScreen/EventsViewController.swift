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
    
    private let segmentedControl = CustomSegmentedControl(items: ["UPCOMING", "PAST EVENTS"])
    
    private let noEventsView = NoUpcomingEventView()
    
    private let exploreEventsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("EXPLORE EVENTS", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 15
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

    }
    
    private func setupViews() {
        view.addSubview(eventsLabel)
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noEventsView)
        noEventsView.translatesAutoresizingMaskIntoConstraints = false
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
            
            noEventsView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 130),
            noEventsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            exploreEventsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -128),
            exploreEventsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exploreEventsButton.heightAnchor.constraint(equalToConstant: 58),
            exploreEventsButton.widthAnchor.constraint(equalToConstant: 271)
            
        ])
    }
}
