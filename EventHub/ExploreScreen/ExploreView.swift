//
//  ExploreView.swift
//  EventHub
//
//  Created by Екатерина Орлова on 25.11.2024.
//

import UIKit

struct Images:  Decodable {
    let image: String
    let date: String
    let nameEvents: String
    let favorites_count: String
    let location: String
}

enum Section: Int, CaseIterable {
    case upcomingCollection = 0
    case nearbyCollection = 1
    
}
class ExploreView: UIView {
    
    private var images: [Images] = [
        Images(
            image: "image84",
            date: "123",
            nameEvents: "123",
            favorites_count: "123",
            location: "123"
        ),
        Images(
            image: "image84",
            date: "123",
            nameEvents: "123",
            favorites_count: "123",
            location: "123"
        )
    ]
    
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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
                    leading: 20,
                    bottom: 24,
                    trailing: 20
                )
                
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
                    leading: 20,
                    bottom: 24,
                    trailing: 20
                )
                
                return section
            }
        }
    }
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(collectionView)
        collectionView.collectionViewLayout = createLayout()
        
    }
    func makeConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

extension ExploreView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case Section.upcomingCollection.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingEventsCell.identifire, for: indexPath) as? UpcomingEventsCell else {
                return UICollectionViewCell()
            }
            let image = images[indexPath.item].image
            let date = images[indexPath.item].date
            let name = images[indexPath.item].nameEvents
            let numbers = images[indexPath.item].favorites_count
            let location = images[indexPath.item].location
            
            cell.config(imageView: UIImage(named: image)! , dateLabel: date, nameLabel: name, numbersLabel: numbers, locationLabel: location)
            return cell
        case Section.nearbyCollection.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:NearbyEventsCell.identifire, for: indexPath) as? NearbyEventsCell else {
                return UICollectionViewCell()
            }
            let image = images[indexPath.item].image
            let date = images[indexPath.item].date
            let name = images[indexPath.item].nameEvents
            let numbers = images[indexPath.item].favorites_count
            let location = images[indexPath.item].location
            cell.config(imageView: UIImage(named: image)! , dateLabel: date, nameLabel: name, numbersLabel: numbers, locationLabel: location)
            return cell
        default:
            return UICollectionViewCell()
        }

    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
    }

