//
//  NearbyEventsCell.swift
//  EventHub
//
//  Created by Екатерина Орлова on 26.11.2024.
//

import UIKit

class NearbyEventsCell: UICollectionViewCell {
    
    static let identifire = "NearbyEventsCell"
    
    private let backgroungCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 15
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let eventBackgroungView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"image 84")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var dateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "10 JUN"
        label.textColor = .redAccent
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Bookmark_white"), for: .normal)
        button.setImage(UIImage(named: "Bookmark_red"), for: .selected)
        button.backgroundColor = .lightGray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "International Band Mu..."
        label.textColor = .titleColor
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let peopleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"people")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let numbersLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 20 Going"
        label.textColor = .blueForButtonExplore
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named:"Map_pin")
//        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "36 Guild Street London, UK "
        label.textColor = .subColor
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(imageView: UIImage, dateLabel: String, nameLabel: String, numbersLabel: String, locationLabel: String ) {
        
        DispatchQueue.main.async {
            self.imageView.image = imageView
            self.dateLabel.text = dateLabel
            self.saveButton.isUserInteractionEnabled = true
            self.nameLabel.text = nameLabel
            self.numbersLabel.text = numbersLabel
            self.locationLabel.text = locationLabel
        }
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    private func setupUI() {
        addSubview(backgroungCell)
        backgroungCell.addSubview(eventBackgroungView)
        eventBackgroungView.addSubview(imageView)
        imageView.addSubview(dateView)
        dateView.addSubview(dateLabel)
        imageView.addSubview(saveButton)
        eventBackgroungView.addSubview(nameLabel)
        eventBackgroungView.addSubview(peopleImageView)
        eventBackgroungView.addSubview(numbersLabel)
        eventBackgroungView.addSubview(locationImageView)
        eventBackgroungView.addSubview(locationLabel)
    }
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            eventBackgroungView.topAnchor.constraint(equalTo: topAnchor),
            eventBackgroungView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventBackgroungView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventBackgroungView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: eventBackgroungView.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 131),
            
            dateView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 2),
            dateView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -2),
            dateView.widthAnchor.constraint(equalToConstant: 46),
            dateView.heightAnchor.constraint(equalToConstant: 45),
            
            dateLabel.centerXAnchor.constraint(equalTo: dateView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: dateView.centerYAnchor),
            
            saveButton.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -2),
            saveButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -2),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 30),
            
            nameLabel.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: -5),
            nameLabel.topAnchor.constraint(equalTo: eventBackgroungView.bottomAnchor, constant: 5),
            
            peopleImageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 5),
            peopleImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            peopleImageView.trailingAnchor.constraint(equalTo: numbersLabel.leadingAnchor, constant: 2),
            
            numbersLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            numbersLabel.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: 2),
            numbersLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: 2),
            
            locationImageView.leadingAnchor.constraint(equalTo: eventBackgroungView.leadingAnchor, constant: 5),
            locationImageView.topAnchor.constraint(equalTo: peopleImageView.bottomAnchor, constant: 2),
            locationImageView.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: 2),
            locationImageView.bottomAnchor.constraint(equalTo: eventBackgroungView.bottomAnchor, constant: 5),
            
            locationLabel.topAnchor.constraint(equalTo: numbersLabel.bottomAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: eventBackgroungView.trailingAnchor, constant: 2),
            locationLabel.bottomAnchor.constraint(equalTo: eventBackgroungView.bottomAnchor, constant: 5)
        ])
    }
}
