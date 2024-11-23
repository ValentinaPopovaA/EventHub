//
//  SearchScreen.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector (backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "  Search"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.leftView = UIImageView(image: searchIcon)
            searchTextField.leftViewMode = .always
        }
        
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField,
           let iconImageView = searchTextField.leftView as? UIImageView {
            iconImageView.tintColor = .blue  // Цвет кастомной лупы
        }
        
        return searchBar
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filters", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 18
        let filterImage = UIImage(named: "filter-circle")
        
        button.setImage(filterImage, for: .normal)
        button.tintColor = .white
        
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // сдвиг изображения влево
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // сдвиг текста вправо
        
        button.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(filterButton)
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
        filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        searchBar.delegate = self
    }
    
    @objc private func didTapFilterButton() {
        print("Filters button tapped")
        // Добавьте логику для отображения экрана фильтров
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
            searchBar.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: -10),
            
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 80),
            filterButton.heightAnchor.constraint(equalToConstant: 36),
            
            noResultLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 200),
            noResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
