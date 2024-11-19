//
//  TabBarControllerViewController.swift
//  EventHub
//
//

import UIKit


class CustomTabBar: UITabBar {
    private lazy var centerView: UIView  = {
        let element = UIView()
        element.backgroundColor = .white
        element.layer.cornerRadius = 30
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 0, height: -3)
        element.layer.shadowOpacity = 0.1
        element.layer.shadowRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        let curveWidth: CGFloat = 60
        let curveHeight: CGFloat = 30
        
        centerView.frame = CGRect(
            x: (frame.width - curveWidth) / 2,
            y: -curveHeight / 2,
            width: curveWidth,
            height: curveHeight
        )
        
        if centerView.superview == nil {
            addSubview(centerView)
        }
    }
}
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupCenterButton()
        delegate = self
        
    }
    
    //MARK: - Setup TabBar
    
    private func setupTabBar() {
        
        let customTabBar = CustomTabBar()
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .gray
        
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(
            title: "Explore",
            image: UIImage(systemName: "safari"),
            selectedImage: UIImage(systemName: "safari.fill"))
        
        
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar.circle.fill"))
        
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: ""),
            selectedImage: UIImage(systemName: ""))
        
        
        let mapVC = MapViewController()
        mapVC.tabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill"))
        
        
        let profileVC = ProfileViewController ()
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [exploreVC, eventsVC, favoritesVC, mapVC, profileVC]
        
    }
    
    //MARK: - Setup Center Button
    
    private func setupCenterButton() {
        let buttonSize: CGFloat = 50
        
        centerButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        centerButton.backgroundColor = .systemBlue
        centerButton.layer.cornerRadius = buttonSize / 2
        
        
        centerButton.layer.shadowColor = UIColor.black.cgColor
        centerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        centerButton.layer.shadowOpacity = 0.3
        centerButton.layer.shadowRadius = 4
        
        let image = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        centerButton.setImage(image, for: .normal)
        centerButton.tintColor = .white
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        view.addSubview(centerButton)
        
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor),
            centerButton.widthAnchor.constraint(equalToConstant: buttonSize),
            centerButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
        ])
        
    }
    
    @objc private func centerButtonTapped(_ sender: UIButton) {
        selectedIndex = 2
        
        let redColor = UIImage(systemName: "bookmark.fill")?.withRenderingMode(.alwaysTemplate)
        centerButton.setImage(redColor, for: .normal)
        centerButton.tintColor = .systemRed
        
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex != 2 {
            let whiteImage = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
            centerButton.setImage(whiteImage, for: .normal)
            centerButton.tintColor = .white
        }
        
    }
}
    
