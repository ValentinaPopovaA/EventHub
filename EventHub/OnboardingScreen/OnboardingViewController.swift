//
//  ViewController.swift
//  EventHub
//
//  Created by Валентина Попова on 16.11.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let titles = ["Welcome to EventHub",
                          "Explore Upcoming and    Nearby Events",
                          "Your Personalized Event Schedule"
    ]
    
    private let descriptions = ["Your personal guide to exciting events, tailored to your interests. Sign in to unlock the experience!",
                                "Discover events happening around you and stay updated with the latest happenings in your area",
                                "Keep track of all upcoming and past events, and never miss out on moments that matter to you."
    ]
    
    private let imageNames = ["Scr1", "Scr2", "Scr3"]
    private var currentIndexPage = 0
    
    // MARK: - UI Elements
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Scr1"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let overlayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        
//        stackView.backgroundColor = UIColor(named: "primaryBlue")
        stackView.backgroundColor = UIColor(red: 0.337, green: 0.41, blue: 1, alpha: 1)
        stackView.layer.cornerRadius = 48
        stackView.layer.masksToBounds = true
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        let text = "Welcome to EventHub"

        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        
        //? задаем стиль и межстрочный интервал
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 22, weight: .bold),
                .paragraphStyle: paragraphStyle
            ]
        )
        label.attributedText = attributedString
        //?
        
        label.textAlignment = .center
        return label
        //
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        let text = "Your personal guide to exciting events, tailored to your interests. Sign in to unlock the experience!"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.font = UIFont(name: "AirbnbCerealWBd", size: 15)
        label.textColor = .white
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .paragraphStyle: paragraphStyle
            ]
        )
        label.attributedText = attributedString
        
        label.textAlignment = .center
        return label

    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Skip", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        return pageControl
    }()
    
    private lazy var buttonStack:  UIStackView = {
        let stack = UIStackView(arrangedSubviews: [skipButton, pageControl, nextButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        
        nextButton.addTarget(self, action: #selector(pressedNextButton), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(pressedSkipButton), for: .touchUpInside)
    }
 
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView)
        view.addSubview(overlayStackView)
        
        overlayStackView.addArrangedSubview(titleLabel)
        overlayStackView.addArrangedSubview(descriptionLabel)
        overlayStackView.addArrangedSubview(buttonStack)
    
    }
    
    // MARK: - Setup Constraint
    
    private func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75),
            
            overlayStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayStackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -288),
            overlayStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: overlayStackView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
  
    
    //MARK: - Methods
 
    @objc private func pressedNextButton() {
        guard currentIndexPage < titles.count - 1 else {
            pressedSkipButton()
                print("Last page")
                return
            }
            
        currentIndexPage += 1
            updateContent()
    }
    
    @objc private func pressedSkipButton() {
        let loginVC = LoginViewController()
//        loginVC.modalPresentationStyle = .fullScreen
//        self.present(loginVC, animated: true, completion: nil)
        navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    private func updateContent() {
        titleLabel.text = titles[currentIndexPage]
        descriptionLabel.text = descriptions[currentIndexPage]
        pageControl.currentPage = currentIndexPage
        
        let imageName = imageNames[currentIndexPage]
        backgroundImageView.image = UIImage(named: imageName)
    }
    
    
}

//#Preview {    OnboardingViewController()}


