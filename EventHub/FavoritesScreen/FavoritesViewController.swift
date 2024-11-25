//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//
import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = .systemFont(ofSize: 24) //.airbnbCerealWBd24()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let noFavoritesView = NoFavoritesView()
    private let tableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(favoritesLabel)
        view.addSubview(searchButton)
        view.addSubview(noFavoritesView)
        view.addSubview(tableView)
    }
    
    @objc private func searchButtonPressed() {
        let allEventsViewController = SearchViewController()
        allEventsViewController.modalPresentationStyle = .fullScreen
        present(allEventsViewController, animated: true)
    }
}

extension FavoritesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            favoritesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            favoritesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            noFavoritesView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 200),
            noFavoritesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noFavoritesView.heightAnchor.constraint(equalToConstant: 200),
            noFavoritesView.widthAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
            
        ])
    }
}
