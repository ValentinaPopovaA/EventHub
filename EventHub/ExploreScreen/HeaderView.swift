//
//  HeaderView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 26.11.2024.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let identifire = "headerID"
    private let  headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
     var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleColor
        label.text = "Nearby You"
        label.font = .systemFont(ofSize:18 )
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "see_all"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        addSubview(headerStack)
        headerStack.addSubview(headerLabel)
        headerStack.addSubview(button)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerStack.heightAnchor.constraint(equalToConstant: 31)
        ])
    }
}
