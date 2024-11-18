//
//  ViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 16.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var label = UILabel.makeCustomLabel(text: "Hello", fontSize: 16, textColor: .white, numberOfLines: 0, textAligment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        makeConstraints()
    }
    
    private func makeConstraints() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
}

