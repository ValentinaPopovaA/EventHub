//
//  AllEventsScreenViewController.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class AllEventsScreenViewController: UIViewController {
    
    private let eventService = EventService()
    private var upcomingEvents: [Event] = []
    
    // UI Элементы
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.text = "Upcoming Events"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = EventsTableView()
    private let noEventsView = NoUpcomingEventView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        tableView.eventsDelegate = self
        tableView.currentSegment = .upcoming
        fetchUpcomingEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    private func setupViews() {
        view.addSubview(backButton)
        view.addSubview(eventsLabel)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        view.addSubview(noEventsView)
        
        noEventsView.isHidden = true
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            eventsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            eventsLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noEventsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noEventsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noEventsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noEventsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func backButtonPressed() {
        self.backButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.backButton.alpha = 1
        }
        self.dismiss(animated: true)
    }
    
    @objc private func searchButtonPressed() {
        let searchViewController = SearchViewController()
        let navController = UINavigationController(rootViewController: searchViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    private func fetchUpcomingEvents() {
        guard let selectedCity = SelectedCityManager.getSelectedCity() else {
            noEventsView.isHidden = false
            tableView.isHidden = true
            return
        }
        
        let currentTime = Int(Date().timeIntervalSince1970)
        let futureTime = currentTime + (365 * 24 * 60 * 60) // события на год
        
        eventService.fetchEvents(
            actualSince: currentTime,
            actualUntil: futureTime,
            sortAscending: true,
            location: selectedCity.slug
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.upcomingEvents = events
                    self?.updateTableView()
                case .failure(let error):
                    print("Ошибка при загрузке предстоящих событий: \(error)")
                    self?.noEventsView.isHidden = false
                    self?.tableView.isHidden = true
                }
            }
        }
    }
    
    private func updateTableView() {
        if upcomingEvents.isEmpty {
            noEventsView.isHidden = false
            tableView.isHidden = true
        } else {
            noEventsView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData(with: upcomingEvents)
        }
    }
}

extension AllEventsScreenViewController: EventsTableViewDelegate {
    func didSelectEvent(_ event: Event, segment: Segment) {
        let detailVC = EventsDetailViewController(event: event, segment: segment)
        detailVC.modalPresentationStyle = .fullScreen
        if let navController = self.navigationController {
            navController.pushViewController(detailVC, animated: true)
        } else {
            present(detailVC, animated: true)
        }
    }
}
