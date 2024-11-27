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
    func searchBarDidSearch(_ searchText: String)
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
        
        search.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
        )
        
        search.searchTextField.textColor = .white
        search.searchTextField.tintColor = .white
        search.searchTextField.clearButtonMode = .whileEditing
        search.searchTextField.font = UIFont(name: "AirbnbCereal_W_Bk", size: 20)
        
        search.searchTextField.leftView = nil
        
        if let clearButton = search.searchTextField.value(forKey: "clearButton") as? UIButton {
            clearButton.tintColor = .white.withAlphaComponent(0.6)
            let tintedImage = clearButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(tintedImage, for: .normal)
        }
        
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
    
    func updateClearButtonColor(with color: UIColor) {
            if let clearButton = searchBar.searchTextField.value(forKey: "clearButton") as? UIButton {
                clearButton.tintColor = color
                let tintedImage = clearButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                clearButton.setImage(tintedImage, for: .normal)
            }
        }
    
    func updateSearchButtonIcon(with imageName: String) {
        let newImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        searchButton.setImage(newImage, for: .normal)
    }
    
    func updateTextFieldTextColor(with color: UIColor) {
        searchBar.searchTextField.textColor = color
    }
    
    func updateCursorColor(with color: UIColor) {
            searchBar.searchTextField.tintColor = color
        }
    
    func updatePlaceholderTextColor(_ color: UIColor) {
        let placeholder = "Search..."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: attributes
        )
    }
    
    func updateSeporatoryView(with color: UIColor) {
        separatorView.backgroundColor = color
    }

    
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
        addSubview(searchButton)
        addSubview(separatorView)
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),

            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            
            separatorView.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            separatorView.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 12),
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.heightAnchor.constraint(equalToConstant: 20)
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
        delegate?.searchBarDidSearch(searchBar.text ?? "")
    }
    
    private func searchAction(_ action: UIAction) {
        searchBarSearchButtonClicked(searchBar)
    }
    
    // MARK: - Internal Methods
    func toggleSearchButton(with value: Bool) {
        searchButton.isEnabled = value
    }
    
    func setSearchText(_ text: String) {
        searchBar.text = text
    }
}
