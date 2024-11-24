//
//  ExploreViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 17.11.2024.
//

import UIKit

class ExploreViewController: UIViewController {
    
    let button = CustomButton(title: "out", isBlue: true, fontSize: .med)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        button.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
    

    @objc private func didTapLogout() {
            AuthService.shared.signOut { [weak self] error in
                guard let self = self else {return }
                if let error = error {
                    
                    return
                }
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }
}
