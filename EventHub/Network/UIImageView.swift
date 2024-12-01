//
//  UIImageView.swift
//  EventHub
//
//  Created by Валентина Попова on 20.11.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(from url: String, placeholder: UIImage? = UIImage(named: "globe")) {
            guard let imageURL = URL(string: url) else { return }
            self.kf.setImage(
                with: imageURL,
                placeholder: placeholder,
                options: [.transition(.fade(0.2))]
            )
        }
//    func loadImage(from url: String) {
//        guard let imageURL = URL(string: url) else { return }
//        URLSession.shared.dataTask(with: imageURL) { data, _, error in
//            if let error = error {
//                print("Failed to load image: \(error)")
//                return
//            }
//            guard let data = data, let image = UIImage(data: data) else { return }
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }.resume()
//    }
}
