//
//  LoginViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let headerView = AuthHeaderView(title: "EventHub", subTitle: "Sign in")
    
    
    // MARK: - LifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.view.backgroundColor = .systemBackground
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(headerView)
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.headerView.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor),
            self.headerView.widthAnchor.constraint(equalToConstant: 270)
        ])
        
        
    }

}
