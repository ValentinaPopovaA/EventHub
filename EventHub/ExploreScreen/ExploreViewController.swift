//
//  ExploreViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit

final class ExploreViewController: UIViewController {
    
    private let blueBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueBackground
        view.layer.cornerRadius = 33
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Current Location", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 14)
        button.alpha = 0.8
        button.setImage(UIImage(named: "Down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        return button
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bell"), for: .normal)
        button.backgroundColor = .blueForButtonExplore
        button.layer.cornerRadius = 18
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cityLabel = UILabel.makeCustomLabel(text: "New York, USA",
                                                    font: UIFont(name: "Arial", size: 15) ?? .systemFont(ofSize: 15),
                                                    textColor: .white,
                                                    numberOfLines: 1,
                                                    textAligment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
        layoutViews()
    }
    
    // MARK: - Private Methods
    private func setViews() {
        view.addSubview(blueBackgroundView)
        view.addSubview(currentLocationButton)
        view.addSubview(cityLabel)
        view.addSubview(notificationButton)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            blueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            blueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueBackgroundView.heightAnchor.constraint(equalToConstant: 200),
            
            currentLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            currentLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            cityLabel.topAnchor.constraint(equalTo: currentLocationButton.bottomAnchor, constant: 6),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            notificationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            notificationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            notificationButton.heightAnchor.constraint(equalToConstant: 36),
            notificationButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
}
