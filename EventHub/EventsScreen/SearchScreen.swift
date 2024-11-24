//
//  SearchScreen.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class SearchViewController: UIViewController,SearchBarDelegate {
    
    
    // MARK: - UI Elements
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchBar: SearchBarView = {
        let searchBar = SearchBarView()
        searchBar.delegate = self
        searchBar.updateSearchButtonIcon(with: "Search_blue")
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
        return button
    }()
    
    private let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "NO RESULTS"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        setupActions()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(searchLabel)
        view.addSubview(searchBar)
        view.addSubview(filtersButton)
        view.addSubview(noResultLabel)
    }
    
    // MARK: - Actions
    @objc func backButtonPressed() {
        self.backButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.backButton.alpha = 1
        })
        self.dismiss(animated: true)
    }
    
    private func setupActions() {
        // Действие для кнопки фильтра
        filtersButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        searchBar.delegate = self
    }
    
    @objc private func didTapFilterButton() {
        print("Filters button tapped")
        // логика для отображения экрана фильтров
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text: \(searchText)")
        // логика для поиска
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search button clicked with text: \(searchBar.text ?? "")")
        searchBar.resignFirstResponder()
        // логикуадля выполнения поиска
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
            searchBar.trailingAnchor.constraint(equalTo: filtersButton.leadingAnchor),
            
            filtersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filtersButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filtersButton.heightAnchor.constraint(equalToConstant: 32),
            filtersButton.widthAnchor.constraint(equalToConstant: 80),
            
            noResultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 200),
            noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func searchBarTextDidChange(_ searchText: String) {
        print("Search text changed: \(searchText)")
    }
    
    func searchBarDidCancel() {
        print("Search cancelled")
    }
}
