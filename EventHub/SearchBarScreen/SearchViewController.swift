//
//  SearchScreen.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class SearchViewController: UIViewController, SearchBarDelegate {
    
    // MARK: - UI Elements
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchBar: SearchBarView = {
        let searchBar = SearchBarView()
        searchBar.delegate = self
        searchBar.updateSearchButtonIcon(with: "Search_blue")
        searchBar.updateSeporatoryView(with: .blueBackground)
        searchBar.updatePlaceholderTextColor(.gray)
        searchBar.updateTextFieldTextColor(with: .black )
        searchBar.updateCursorColor(with: .blueForButtonExplore)
        searchBar.updateClearButtonColor(with: .blueForButtonExplore)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "  Search"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filtersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filters", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCereal_W_Bk", size: 12)
        button.setImage(UIImage(named: "Filter_circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blueForButtonExplore
        button.layer.cornerRadius = 16
        button.semanticContentAttribute = .forceLeftToRight
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        return button
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "NO RESULTS"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true // Изначально скрыт
        return label
    }()
    
    private let tableView = SearchTableView()
    
    private var searchResults: [Event] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(searchLabel)
        view.addSubview(searchBar)
        view.addSubview(filtersButton)
        view.addSubview(noResultLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.idTableViewCell)
    }
    
    // MARK: - Actions
    @objc func backButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapFilterButton() {
        print("Filters button tapped")
        // Логика для отображения экрана фильтров
    }
    
    // MARK: - SearchBarDelegate
    func searchBarTextDidChange(_ searchText: String) {
        print("Search text changed: \(searchText)")
        if searchText.isEmpty {
            searchResults.removeAll()
            noResultLabel.isHidden = true
            tableView.reloadData()
        } else {
            performSearch(query: searchText)
        }
    }
    
    func searchBarDidCancel() {
        print("Search cancelled")
        searchResults.removeAll()
        noResultLabel.isHidden = true
        tableView.reloadData()
    }
    
    // MARK: - Search
    private func performSearch(query: String) {
        guard let selectedCity = SelectedCityManager.getSelectedCity() else {
            print("Город не выбран")
            noResultLabel.text = "Город не выбран"
            noResultLabel.isHidden = false
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
        
        // Показываем индикатор загрузки
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        let searchRequest = SearchEventsRequest(
            headers: [:],
            query: query,
            citySlug: selectedCity.slug
        )
        
        let networkService = NetworkService()
        networkService.request(searchRequest) { [weak self] (result: Result<[Event], Error>) in
            DispatchQueue.main.async {
                // Скрываем индикатор загрузки
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                switch result {
                case .success(let events):
                    self?.searchResults = events
                    self?.noResultLabel.text = events.isEmpty ? "NO RESULTS" : ""
                    self?.noResultLabel.isHidden = !events.isEmpty
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Ошибка при поиске событий: \(error)")
                    self?.noResultLabel.text = "Ошибка при поиске"
                    self?.noResultLabel.isHidden = false
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.idTableViewCell, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let event = searchResults[indexPath.row]
        cell.configure(with: event)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Обработка выбора ячейки
        let selectedEvent = searchResults[indexPath.row]
        // Переход к деталям события, если необходимо
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Настройте высоту ячейки по необходимости
    }
}

extension SearchViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 22),
            
            searchLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 40),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: filtersButton.leadingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filtersButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filtersButton.heightAnchor.constraint(equalToConstant: 32),
            filtersButton.widthAnchor.constraint(equalToConstant: 80),
            
            noResultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
