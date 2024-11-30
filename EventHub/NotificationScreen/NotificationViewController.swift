//
//  NotificationViewController.swift
//  EventHub
//
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDataSource {
    //MARK: - Elements UI
    private lazy var tableView: UITableView  = {
        let element = UITableView()
        element.separatorStyle = .none
        element.backgroundColor = .systemBackground
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.font = .systemFont(ofSize: 24) 
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc func backButtonPressed() {
        self.backButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.backButton.alpha = 1
        })
        self.dismiss(animated: true)
    }
    

    private var notifications: [UserNotification] = [
        UserNotification(title: "International Band Music Concert coming soon!", date: "Just now"),
        UserNotification(title: "International Band Music Concert coming soon!", date: "7 days ago"),
        UserNotification(title: "International Band Music Concert coming soon!", date: "14 days ago")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
    }
    //MARK: - Private Methods
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(navigationLabel)
        view.addSubview(backButton)
        view.backgroundColor = .systemBackground
      
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
           navigationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navigationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.dataSource = self
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
            }
      
    //MARK: - Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else {
            fatalError("Could not dequeue cell with identifier: NotificationCell")
        }
        let notification = notifications[indexPath.row]
        cell.configure(with: notification)
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
class NoNotificationsViewController: UIViewController {
    
    private let noNotificationView = NoNotificationViewController(frame: .zero)
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
        return button
    }()
    @objc func backButtonPressed() {
        self.backButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.backButton.alpha = 1
        })
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(noNotificationView)
        view.addSubview(backButton)
        
        
        NSLayoutConstraint.activate([
            noNotificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noNotificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noNotificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noNotificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 22),
        
        ])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
