//
//  CustomSegmentedControl.swift
//  EventHub
//
//  Created by apple on 11/18/24.
//

import UIKit

class CustomSegmentedControl: UIView {
    
    // Массив для хранения кнопок сегментов
    private var buttons: [UIButton] = []
    
    // Индекс выбранного сегмента
    private(set) var selectedSegmentIndex: Int = 0
    
    // Для обработки изменений сегмента
    var valueChanged: ((Int) -> Void)?
    
    // Инициализация с сегментами
    init(items: [String]) {
        super.init(frame: .zero)
        
        // Создаем кнопки для каждого сегмента
        for (index, item) in items.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(item, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.gray, for: .selected)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.tag = index  // Присваиваем тег сегмента
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            
            buttons.append(button)
        }
        
        // Добавляем кнопки в стек
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 20
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // Отступы
        stackView.isLayoutMarginsRelativeArrangement = true  // Включаем использование отступов

                addSubview(stackView)
        
        // Auto Layout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Сначала активируем первый сегмент
        updateSegmentAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Обработчик нажатия на сегмент
    @objc private func segmentTapped(_ sender: UIButton) {
        // Изменяем выбранный сегмент
        selectedSegmentIndex = sender.tag
        updateSegmentAppearance()
        
        // Вызов обработчика
        valueChanged?(selectedSegmentIndex)
    }
    
    // Обновляем внешний вид сегментов
    private func updateSegmentAppearance() {
        for (index, button) in buttons.enumerated() {
            if index == selectedSegmentIndex {
                // Активный сегмент
                button.backgroundColor = .white
                button.setTitleColor(.blue, for: .normal)
            } else {
                // Неактивный сегмент
                button.backgroundColor = .clear
                button.setTitleColor(.white, for: .normal)
            }
        }
    }
}

