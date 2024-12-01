//
//  EventsViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit
import Foundation

class EventsViewController: UIViewController, EventsTableViewDelegate {
    
    private let eventsTableView = EventsTableView()
    private var upcomingEvents: [Event] = []
    private var pastEvents: [Event] = []
    
    private var upcomingContentOffset: CGPoint = .zero
    private var pastContentOffset: CGPoint = .zero
    
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
        tableView.eventsDelegate = self
        loadEvents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityDidChange), name: .cityDidChange, object: nil)
    }
    
    
    
    private func setupViews() {
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noEventsView)
        noEventsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(buttonBlue)
        self.navigationItem.titleView = eventsLabel
        
        tableView.parentViewController = self
        segmentedControl.valueChanged = { [weak self] selectedIndex in
            self?.segmentedChange()
        }
    }
 

    private func loadEvents() {
        guard let selectedCity = SelectedCityManager.getSelectedCity() else {
            noEventsView.isHidden = false
            tableView.isHidden = true
            return
        }
        
        let currentTime = Int(Date().timeIntervalSince1970)
        let sevenDaysAgo = currentTime - (7 * 24 * 60 * 60)
        let sevenDaysLater = currentTime + (7 * 24 * 60 * 60)
        
        let eventService = EventService()
        let dispatchGroup = DispatchGroup()
        
        // Запрос предстоящих событий
        dispatchGroup.enter()
        eventService.fetchEvents(
            actualSince: currentTime,
            actualUntil: sevenDaysLater,
            sortAscending: true, // Сортировка по возрастанию для предстоящих событий
            location: selectedCity.slug // Передаем slug города
        ) { [weak self] (result: Result<[Event], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.upcomingEvents = events
                case .failure(let error):
                    print("Ошибка при загрузке предстоящих событий: \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        // Запрос прошедших событий
        dispatchGroup.enter()
        eventService.fetchEvents(
            actualSince: sevenDaysAgo,
            actualUntil: currentTime,
            sortAscending: false, // Сортировка по убыванию для прошедших событий
            location: selectedCity.slug // Передаем slug города
        ) { [weak self] (result: Result<[Event], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let events):
                    self?.pastEvents = events
                case .failure(let error):
                    print("Ошибка при загрузке прошедших событий: \(error)")
                }
                dispatchGroup.leave()
            }
        }
        
        // Обновление UI после завершения обоих запросов
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.updateUI(for: self?.segmentedControl.selectedSegmentIndex == 0 ? .upcoming : .past)
        }
    }
    
    @objc private func segmentedChange() {
        if segmentedControl.selectedSegmentIndex == 0 {
            pastContentOffset = tableView.contentOffset
            updateUI(for: .upcoming)
            tableView.setContentOffset(upcomingContentOffset, animated: false)
        } else {
            upcomingContentOffset = tableView.contentOffset
            updateUI(for: .past)
            tableView.setContentOffset(pastContentOffset, animated: false)
        }
    }
    
 
    
    func didSelectEvent(_ event: Event, segment: Segment) {
        let eventsDetailVC = EventsDetailViewController(event: event, segment: segment)
        eventsDetailVC.modalPresentationStyle = .fullScreen
        present(eventsDetailVC, animated: true)
    }
    
    private func updateUI(for segment: Segment) {
        switch segment {
        case .upcoming:
            tableView.reloadData(with: upcomingEvents)
            noEventsView.isHidden = !upcomingEvents.isEmpty
            tableView.isHidden = upcomingEvents.isEmpty
        case .past:
            tableView.reloadData(with: pastEvents)
            noEventsView.isHidden = !pastEvents.isEmpty
            tableView.isHidden = pastEvents.isEmpty
        }
    }
    
    @objc private func buttonTapped() {
        let allEventsViewController = AllEventsScreenViewController()
        allEventsViewController.modalPresentationStyle = .fullScreen
        present(allEventsViewController, animated: true)
    }
    
    @objc private func cityDidChange() {
        loadEvents()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cityDidChange, object: nil)
    }
    
    //    private func checkEventsToday() {
    //        noEventsView.isHidden = !eventsArray.isEmpty
    //        tableView.isHidden = eventsArray.isEmpty
    //    }
}

extension EventsViewController {
    
    private func setConstrainst() {
        NSLayoutConstraint.activate([

            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
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
