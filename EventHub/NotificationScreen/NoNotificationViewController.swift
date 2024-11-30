//
//  NoNotificationViewController.swift
//  EventHub
//
//

import UIKit

   
import UIKit
//MARK: - UI Elements
    class NoNotificationViewController: UIView {
        private let noNotificationImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "noNot")
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .lightGray
            imageView.layer.cornerRadius = 150
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        private let navigationLabel: UILabel = {
            let label = UILabel()
            label.text = "Notification"
            label.font = .systemFont(ofSize: 24)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
       
       
        
        private let noNotificationLabel: UILabel = {
            let label = UILabel()
            label.text = "No Notifications!"
            label.font = .systemFont(ofSize: 18)
            label.textColor = .black
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let noNotificationDescriptionLabel: UILabel = {
            let label = UILabel()
            label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor"
            label.font = .systemFont(ofSize: 16)
            label.textAlignment = .center
            label.numberOfLines = 2
            label.textColor = .lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var stackView: UIStackView  = {
            let element = UIStackView()
            element.axis = .vertical
            element.spacing = 15
            element.addArrangedSubview(noNotificationLabel)
            element.addArrangedSubview(noNotificationDescriptionLabel)
            
            element.translatesAutoresizingMaskIntoConstraints = false
            return element
        }()
   
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
            setConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK: - Private Method
        private func setupViews() {
            translatesAutoresizingMaskIntoConstraints = false
            addSubview(noNotificationImageView)
            addSubview(stackView)
            addSubview(navigationLabel)
        }
        
    }
//MARK: - Extension
    extension NoNotificationViewController {
        private func setConstraints() {
            NSLayoutConstraint.activate([
//              No Notification Image View
                noNotificationImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
                noNotificationImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                noNotificationImageView.heightAnchor.constraint(equalToConstant: 300),
                noNotificationImageView.widthAnchor.constraint(equalToConstant: 300),
                
//              Stack View
                stackView.topAnchor.constraint(equalTo: noNotificationImageView.bottomAnchor, constant: 5),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
                
                navigationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                 navigationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        }
    }
