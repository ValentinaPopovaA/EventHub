import UIKit
class ExploreView: UIView {
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .null,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        backgroundColor = .systemBackground
        addSubview(collectionView)
    func makeConstraints() {
    }
    
}
    }
    }
    }
    }
