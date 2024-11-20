//
//  ShareView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 20.11.2024.
//

import UIKit

class ShareView: UIView {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Share with friends"
        label.textAlignment = .left
        label.font = .systemFont(ofSize:24 , weight: .semibold)
        label.textColor = .titleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    let images: [UIImage] = [
//        UIImage(named: "Copy Link")!,
//        UIImage(named: "Facebook")!,
//        UIImage(named: "Instagram")!,
//        UIImage(named: "Message")!,
//        UIImage(named: "Messenger")!,
//        UIImage(named: "Scype")!,
//        UIImage(named: "Twitter")!,
//        UIImage(named: "WhatsApp")!,
//    ] {
//        
//    }()
    
    let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let linkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Copy_link"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
           
    let facebookButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Facebook"), for: .normal)
       
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let instaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Instagram"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let messageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Message"), for: .normal)
      
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let messengerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Messenger"), for: .normal)
 
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let skypeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Skype"), for: .normal)
       
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let twitterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Twitter"), for: .normal)
      
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let wtsAppButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "WhatsApp"), for: .normal)
       
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
                            
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .grayForDetail
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 25
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func cancelButtonPressed(_ sender: UIButton) {
        self.isHidden = true
    }

       func configUI() {
           addSubview(title)
           addSubview(buttonsStack)
           buttonsStack.addArrangedSubview(linkButton)
           buttonsStack.addArrangedSubview(facebookButton)
           buttonsStack.addArrangedSubview(instaButton)
           buttonsStack.addArrangedSubview(messageButton)
           addSubview(buttonsStackView)
          
           buttonsStackView.addArrangedSubview(messengerButton)
           buttonsStackView.addArrangedSubview(skypeButton)
           buttonsStackView.addArrangedSubview(twitterButton)
           buttonsStackView.addArrangedSubview(wtsAppButton)
           addSubview(cancelButton)
           
           NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),

            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStack.heightAnchor.constraint(equalToConstant: 100),
            buttonsStack.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: 2),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: 20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 100),
            
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            cancelButton.heightAnchor.constraint(equalToConstant: 60)
           ])
       }
    
    
}
