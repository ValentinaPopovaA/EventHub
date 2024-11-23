//
//  ViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 16.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var label = UILabel.makeCustomLabel(text: "Hello", fontSize: 56, textColor: .white, numberOfLines: 0, textAligment: .center)
    
    var button = UIButton.makePurpleButton(label: "Forward", target: self, action: #selector(buttonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        makeConstraints()
    }
    
    private func makeConstraints() {
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            button.widthAnchor.constraint(equalToConstant: 271),
            button.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    @objc func buttonTapped() {
        print("Hello")
    }
}

