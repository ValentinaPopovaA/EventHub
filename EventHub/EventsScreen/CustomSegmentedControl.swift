//
//  CustomSegmentedControl.swift
//  EventHub
//
//  Created by apple on 11/22/24.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    private var buttons: [UIButton] = []
    
    private(set) var selectedSegmentIndex: Int = 0
    
    var valueChanged: ((Int) -> Void)?
    
    init(items: [String], font: UIFont) {
            super.init(frame: .zero)
        
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.gray, for: .selected)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.tag = index
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            
            button.titleLabel?.font = font
            
            buttons.append(button)
        }

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .greyLight
        stackView.layer.cornerRadius = 20
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        addSubview(stackView)
        
        // Auto Layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        updateSegmentAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        
        selectedSegmentIndex = sender.tag
        updateSegmentAppearance()
        
        valueChanged?(selectedSegmentIndex)
    }
    
    private func updateSegmentAppearance() {
        for (index, button) in buttons.enumerated() {
            if index == selectedSegmentIndex {
                // Активный сегмент
                button.backgroundColor = .white
                button.setTitleColor(.blueBackground, for: .normal)
            } else {
                // Неактивный сегмент
                button.backgroundColor = .clear
                button.setTitleColor(.subColor, for: .normal)
            }
        }
    }
}

