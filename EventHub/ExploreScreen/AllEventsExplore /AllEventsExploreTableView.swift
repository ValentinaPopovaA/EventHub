//
//  AllEventsExploreTableView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 01.12.2024.
//

import UIKit

protocol AllEventsExploreTableViewDelegate: AnyObject {
    
}

class AllEventsExploreTableView: UITableView {
    
    weak var parentViewController: UIViewController?
    private var events: [Event] = []
    weak var eventsDelegate: EventsTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        separatorStyle = .none
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

extension AllEventsExploreTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AllEventsExploreCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AllEventsExploreCell else {
            let cell = AllEventsExploreCell(style: .default, reuseIdentifier: cellIdentifier)
            cell.configure(with: events[indexPath.row])
            return cell
        }
        cell.configure(with: events[indexPath.row])
        return cell
    }
}

extension AllEventsExploreTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

