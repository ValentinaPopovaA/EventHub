//
//  ExploreView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 25.11.2024.
//

import UIKit

enum Section: Int, CaseIterable {
    case upcomingCollection = 0
    case nearbyCollection = 1
    
}
class ExploreView: UIView {
    
    private var upcomingEvents: [Event] = []
    private var nearbyEvents: [Event] = []
    weak var parentViewController: UIViewController?

    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .null,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
      
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UpcomingEventsCell.self, forCellWithReuseIdentifier: UpcomingEventsCell.identifire)
        collectionView.register(
            NearbyEventsCell.self,
            forCellWithReuseIdentifier: NearbyEventsCell.identifire
        )
        collectionView.register(UpcomingHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: UpcomingHeaderView.identifire)
        collectionView.register(NearbyHeaderView.self, forSupplementaryViewOfKind: "Header", withReuseIdentifier: NearbyHeaderView.identifire)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let noEventsLabel: UILabel = {
        let label = UILabel()
        label.text = "События не найдены для выбранной категории."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUpcomingEvents(_ events: [Event]) {
        self.upcomingEvents = events
            DispatchQueue.main.async {
                if events.isEmpty {
                    self.noEventsLabel.text = "События не найдены для данной категории"
                    self.noEventsLabel.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.noEventsLabel.isHidden = true
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                }
            }
        collectionView.reloadSections(IndexSet(integer: Section.upcomingCollection.rawValue))
    }
    
    func updateNearbyEvents(_ events: [Event]) {
        self.nearbyEvents = events
        DispatchQueue.main.async {
            if  self.nearbyEvents.isEmpty {
                self.noEventsLabel.text = "События не найдены для данной категории"
                self.noEventsLabel.isHidden = false
                self.collectionView.isHidden = true
            } else {
                self.noEventsLabel.isHidden = true
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
        collectionView.reloadSections(IndexSet(integer: Section.nearbyCollection.rawValue))
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            sectionIndex,
            _ in
            let sectionType = Section.allCases[sectionIndex]
            
            switch sectionType {
            case .upcomingCollection:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(256),
                        heightDimension: .absolute(256)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = CGFloat(16)
                section.contentInsets = .init(
                    top: 24,
                    leading: 5,
                    bottom: 24,
                    trailing: 20
                )
                section.boundarySupplementaryItems = [
                .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: "Header", alignment: .top),
                ]
                return section
                
            case .nearbyCollection:
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(256),
                        heightDimension: .absolute(256)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = CGFloat(16)
                section.contentInsets = .init(
                    top: 24,
                    leading: 5,
                    bottom: 24,
                    trailing: 20
                )
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: "Header", alignment: .top),
                ]
                return section
            }
        }
    }
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(collectionView)
        addSubview(noEventsLabel)
        collectionView.collectionViewLayout = createLayout()
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noEventsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noEventsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            noEventsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            noEventsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

extension ExploreView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == "Header" {
            switch indexPath.section {
            case Section.upcomingCollection.rawValue:
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: "Header",
                    withReuseIdentifier: UpcomingHeaderView.identifire,
                    for: indexPath
                ) as! UpcomingHeaderView
                headerView.config(headerLabel: "Upcoming Events") { [weak self] in
                    self?.didTapSeeAll(section: .upcomingCollection)
                }
                return headerView
            case Section.nearbyCollection.rawValue:
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: "Header",
                    withReuseIdentifier: NearbyHeaderView.identifire,
                    for: indexPath
                ) as! NearbyHeaderView
                headerView.config(headerLabel: "Nearby You") { [weak self] in
                    self?.didTapSeeAll(section: .nearbyCollection)
                }
                return headerView
            default:
                return UICollectionReusableView()
            }
        }
        return UICollectionReusableView()
    }

    func didTapSeeAll(section: Section) {
        guard let navigationController = parentViewController?.navigationController else {
            print("Parent ViewController is nil")
            return
        }
        switch section {
        case .upcomingCollection:
            let upcomingEventsVC = AllEventsExploreViewController()
            upcomingEventsVC.title = "All Upcoming Events"
            upcomingEventsVC.updateEvents(upcomingEvents)
            navigationController.present(upcomingEventsVC, animated: true, completion: nil)
            //            navigationController.navigationController?.pushViewController(upcomingEventsVC, animated: true)
        case .nearbyCollection:
            let nearbyEventsVC = AllEventsExploreViewController()
            nearbyEventsVC.title = "All Nearby Events"
            nearbyEventsVC.updateEvents(nearbyEvents)
            navigationController.present(nearbyEventsVC, animated: true, completion: nil)
            //            navigationController.navigationController?.pushViewController(nearbyEventsVC, animated: true)
        }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        switch sectionType {
        case .upcomingCollection:
            return upcomingEvents.count
        case .nearbyCollection:
            return nearbyEvents.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch sectionType {
        case .upcomingCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventsCell.identifire, for: indexPath) as? UpcomingEventsCell else {
                return UICollectionViewCell()
            }
            let event = upcomingEvents[indexPath.item]
            cell.configure(with: event)
            return cell
        case .nearbyCollection:
            // Пока не реализовано
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyEventsCell.identifire, for: indexPath) as? NearbyEventsCell else {
                return UICollectionViewCell()
            }
            let event = nearbyEvents[indexPath.item]
            cell.configure(with: event)
            return cell
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
    }

