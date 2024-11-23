//
//  SearchBar.swift
//  EventHub
//
//  Created by Валентина Попова on 22.11.2024.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchBarTextDidChange(_ searchText: String)
    func searchBarDidCancel()
}

final class SearchBarView: UIView, UISearchBarDelegate {
    
    weak var delegate: SearchBarDelegate?
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.delegate = self
        
        search.backgroundColor = .clear
        search.backgroundImage = UIImage()
        search.searchTextField.backgroundColor = .clear
        search.searchTextField.layer.cornerRadius = 16
        search.searchTextField.layer.masksToBounds = true
        search.searchTextField.placeholder = "Search..."
        search.searchTextField.textColor = .white
        search.searchTextField.clearButtonMode = .whileEditing
        search.searchTextField.font = UIFont(name: "AirbnbCereal_W_Bk", size: 20)
        
        return search
    }()
    
    private lazy var searchButton: UIButton = {
        let image = UIImage(named: "Search_white")?.withRenderingMode(.alwaysOriginal)
        let action = UIAction(image: image, handler: searchAction)
        let button = UIButton(type: .system, primaryAction: action)
        button.isEnabled = false
        return button
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 1, height: 20)
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(searchBar)
        searchBar.addSubview(searchButton)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),

            searchButton.topAnchor.constraint(equalTo: searchBar.searchTextField.topAnchor, constant: 5),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.searchTextField.leadingAnchor, constant: 5)
        ])
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarTextDidChange(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        delegate?.searchBarDidCancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    private func searchAction(_ action: UIAction) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - Internal Methods
    func toggleSearchButton(with value: Bool) {
        searchButton.isEnabled = value
    }
}
