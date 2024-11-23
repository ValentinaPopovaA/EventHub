//
//  EventTableView.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class EventsTableView: UITableView {
    
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
}

extension EventsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsUITableViewCell.idTableViewCell,
                                                       for: indexPath) as? EventsUITableViewCell  else {
            return UITableViewCell()
        }
        return cell
    }
}

extension EventsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            print("delete cell")
        }
        
        action.backgroundColor = .white
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
