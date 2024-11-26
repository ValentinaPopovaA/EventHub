//
//  CitySelectionViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 24.11.2024.
//

import UIKit

final class CitySelectionViewController: UIViewController {
    private var cities: [City] = []
    private var selectedCity: City?
    
    var onCitySelected: ((City) -> Void)?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 16
        table.separatorStyle = .none
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupUI()
        fetchCities()
    }
    
    private func setupUI() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.addSubview(tableView)
        containerView.addSubview(closeButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func fetchCities() {
        CityService.shared.fetchCities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCities):
                    self?.cities = fetchedCities
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch cities: \(error)")
                }
            }
        }
    }
    
    @objc private func dismissModal() {
        dismiss(animated: true)
    }
}

extension CitySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        let city = cities[indexPath.row]
        
        cell.textLabel?.text = city.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = .black
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        SelectedCityManager.saveSelectedCity(city)
        
        NotificationCenter.default.post(name: .cityDidChange, object: nil)
        
        onCitySelected?(city)
        dismiss(animated: true)
    }
}
