//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//
import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    let exploreView = ExploreView()
    
    private var favorites: Results<FavoriteEvent>!
    private var notificationToken: NotificationToken?
    
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
        button.addTarget(FavoritesViewController.self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let noFavoritesView = NoFavoritesView()
    private let tableView = FavoritesTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        loadFavorites()
        setConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavoritesTable), name: Notification.Name("UpdateFavoritesTable"), object: nil)
    }

    @objc func updateFavoritesTable() {
        // Обновляем таблицу
        tableView.reloadData()
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
    
    private func loadFavorites() {
            let realm = try! Realm()
            favorites = realm.objects(FavoriteEvent.self)
            
            // Добавьте наблюдение за изменениями в базе
            notificationToken = favorites.observe { [weak self] changes in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                        tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                        tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                    })
                case .error(let error):
                    print("Error updating favorites: \(error.localizedDescription)")
                }
            }
        }

        deinit {
            notificationToken?.invalidate()
            NotificationCenter.default.removeObserver(self)
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
