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
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let segmentedControl = CustomSegmentedControl(items: ["UPCOMING", "PAST EVENTS"], font: UIFont(name: "AirbnbCereal_W_Bk", size: 15) ?? .boldSystemFont(ofSize: 20))
    private let noEventsView = NoUpcomingEventView()
    private let tableView = EventsTableView()
    
    private lazy var buttonBlue = UIButton.makePurpleButton(label: "EXPLORE EVENTS",
                                                            target: self,
                                                            action: #selector(buttonTapped))
    
    //private var eventsArray = [EventsModel]()
    
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
        view.addSubview(tableView)
        view.addSubview(buttonBlue)
    }
    
    @objc private func segmentedChange() {
        
    }
    
    @objc private func buttonTapped() {
        let allEventsViewController = AllEventsScreenViewController()
        allEventsViewController.modalPresentationStyle = .fullScreen
        present(allEventsViewController, animated: true)
    }
    
    //    private func checkEventsToday() {
    //        noEventsView.isHidden = !eventsArray.isEmpty
    //        tableView.isHidden = eventsArray.isEmpty
    //    }
}

extension EventsViewController {
    
    private func setConstrainst() {
        NSLayoutConstraint.activate([
            eventsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            eventsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: eventsLabel.bottomAnchor, constant: 22),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            noEventsView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 130),
            noEventsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonBlue.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -128),
            buttonBlue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBlue.heightAnchor.constraint(equalToConstant: 58),
            buttonBlue.widthAnchor.constraint(equalToConstant: 271),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonBlue.bottomAnchor, constant: 10)
            
        ])
    }
}
