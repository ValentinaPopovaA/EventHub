//
//  EventTableView.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

protocol EventsTableViewDelegate: AnyObject {
    func didSelectEvent(_ event: Event)
}

class EventsTableView: UITableView {
    
    private var events: [Event] = []
    weak var eventsDelegate: EventsTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegates()
        register(EventsUITableViewCell.self, forCellReuseIdentifier: EventsUITableViewCell.idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        separatorStyle = .none
        //bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
    
    func reloadData(with events: [Event]) {
        self.events = events
        self.reloadData()
    }
}

extension EventsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsUITableViewCell.idTableViewCell,
                                                       for: indexPath) as? EventsUITableViewCell else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        cell.configure(with: event)
        return cell
    }
}

extension EventsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = events[indexPath.row]
        let detailVC = EventsDetailViewController(eventID: selectedEvent.id)
        navigationController?.pushViewController(detailVC, animated: true)

        // Задержка для снятия выделения
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

