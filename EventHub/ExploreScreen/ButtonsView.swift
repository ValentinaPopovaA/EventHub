//
//  ButtonsView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 29.11.2024.
//

import UIKit

protocol ButtonsViewDelegate: AnyObject {
    func todayButtonTapped()
    func filmsButtonTapped()
    func listsButtonTapped()
}
class ButtonsView: UIView {
        
    var delegate: ButtonsViewDelegate?
    
    private let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.isUserInteractionEnabled = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let todayButton: UIButton = {
        let button = UIButton()
        button.setTitle("TODAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.backgroundColor = .blueBackground
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let filmsButton: UIButton = {
        let button = UIButton()
        button.setTitle("FILMS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.backgroundColor = .blueBackground
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(filmsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let listsButton: UIButton = {
        let button = UIButton()
        button.setTitle("LISTS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.backgroundColor = .blueBackground
        button.layer.cornerRadius = 19
        button.addTarget(self, action: #selector(listsButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc private func todayButtonTapped(_ sender: UIButton) {
//        sender.isSelected.toggle()
//    }
//    @objc private func filmsButtonTapped(_ sender: UIButton) {
//        sender.isSelected.toggle()
//    }
//    @objc private func listsButtonTapped(_ sender: UIButton) {
//        sender.isSelected.toggle()
//    }
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(buttonsStack)
        buttonsStack.addArrangedSubview(todayButton)
        buttonsStack.addArrangedSubview(filmsButton)
        buttonsStack.addArrangedSubview(listsButton)
        
        NSLayoutConstraint.activate([
            buttonsStack.topAnchor.constraint(equalTo: topAnchor),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private extension ButtonsView {
    @objc func todayButtonTapped() {
        delegate?.todayButtonTapped()
    }
    @objc func filmsButtonTapped() {
        delegate?.filmsButtonTapped()
    }
    @objc func listsButtonTapped() {
        delegate?.listsButtonTapped()
    }
}
