//
//  AllEventsExploreViewController.swift
//  EventHub
//
//  Created by Екатерина Орлова on 01.12.2024.
//

import UIKit

class AllEventsExploreViewController: UIViewController {
    private let eventsTableView = AllEventsExploreTableView()
    private var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        eventsTableView.reloadData(with: events)
    }

    private func setupUI() {
        view.addSubview(eventsTableView)
        NSLayoutConstraint.activate([
            eventsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            eventsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func updateEvents(_ events: [Event]) {
        self.events = events
        eventsTableView.reloadData(with: events)
    }
}

