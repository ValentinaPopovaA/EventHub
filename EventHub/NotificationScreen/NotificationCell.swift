//
//  NotificationCell.swift
//  EventHub
//

import UIKit

struct UserNotification {
    let title: String
    let date: String
    
}
class NotificationCell: UITableViewCell {
    //MARK: - Elements UI
    private lazy var containerView: UIView  = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        element.layer.cornerRadius = 20
        element.layer.borderWidth = 0.3
        element.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5).cgColor
        element.layer.shadowColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1).cgColor
        element.layer.shadowOpacity = 0.5
        element.layer.shadowOffset = CGSize(width: 0, height: 4)
        element.layer.shadowRadius = 8
        element.layer.masksToBounds = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel  = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .regular)
        element.numberOfLines = 0
        element.textColor = UIColor(red: 0.24, green: 0.24, blue: 0.23, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var dateLabel: UILabel  = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 12)
        element.textColor = UIColor(red: 0.49, green: 0.49, blue: 0.48, alpha: 1)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup Cell
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
        ])
    }
        func configure(with notification: UserNotification) {
            titleLabel.text = notification.title
            dateLabel.text = notification.date
        
    }
}
