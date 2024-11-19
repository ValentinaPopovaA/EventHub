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
        element.layer.shadowOffset = CGSize(width: 0, height: -3)
        element.layer.shadowOpacity = 0.5
        element.layer.shadowRadius = 10
        element.layer.shouldRasterize = true
        element.layer.rasterizationScale = UIScreen.main.scale
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        
        let curveWidth: CGFloat = 60
        let curveHeight: CGFloat = 30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 15
        layer.masksToBounds = false
        
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
    let customTabBar = CustomTabBar()
    
    let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
        setupTabBar()
        setupCenterButton()
        delegate = self
    }
    
    //MARK: - Setup TabBar
    
    private func setupTabBar() {
        tabBar.tintColor = .primaryBlue
        
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(
            title: "Explore",
            image: UIImage(named: "Compass"),
            selectedImage: UIImage(named: "Compass_blue"))
        
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(named: "Calendar_blue"),
            selectedImage: UIImage(named: "Calendar_blue"))
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: ""),
            selectedImage: UIImage(systemName: ""))
        
        let mapVC = EventsDetailViewController()
        mapVC.tabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(named: "Location_blue"),
            selectedImage: UIImage(named: "Location_blue"))
        
        let profileVC = ProfileViewController ()
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "Profile_blue"),
            selectedImage: UIImage(named: "Profile_blue"))
        
        viewControllers = [exploreVC, eventsVC, favoritesVC, mapVC, profileVC]
    }
    
    //MARK: - Setup Center Button
    
    private func setupCenterButton() {
        let buttonSize: CGFloat = 50
        
        centerButton.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        centerButton.backgroundColor = .primaryBlue
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
        
        let redColor = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        centerButton.setImage(redColor, for: .normal)
        centerButton.backgroundColor = .systemRed
        centerButton.tintColor = .white
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex != 2 {
            centerButton.backgroundColor = .primaryBlue
            let blueImage = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
            centerButton.setImage(blueImage, for: .normal)
            centerButton.tintColor = .white
        }
    }
}
