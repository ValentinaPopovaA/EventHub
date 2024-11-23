//
//  AllEventsScreenViewController.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class AllEventsScreenViewController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
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
        label.text = "Events"
        label.font = .systemFont(ofSize: 24) //.airbnbCerealWBd24()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = EventsTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstrainst()
    }
    
    private func setupViews() {
        view.addSubview(backButton)
        view.addSubview(eventsLabel)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    @objc func backButtonPressed() {
        self.backButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.backButton.alpha = 1
        })
        self.dismiss(animated: true)
    }
    
    @objc private func searchButtonPressed() {
        let allEventsViewController = SearchViewController()
        allEventsViewController.modalPresentationStyle = .fullScreen
        present(allEventsViewController, animated: true)
    }
}

extension AllEventsScreenViewController {
    
    private func setConstrainst() {
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            eventsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            eventsLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
}
