//
//  ImagePicker.swift
//  EventHub
//
//  Created by Максим on 02.12.2024.
//

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
    
    func showImagePicker(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.allowsEditing = true
        viewController.present(imagePickerController!, animated: true)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(cropToCircle(image))
                        
            picker.dismiss(animated: true)
        }
    }
    
    private func cropToCircle(_ image: UIImage) -> UIImage {
        let min = min(image.size.width, image.size.height)
        let squareSize = CGSize(width: min, height: min)
        
        UIGraphicsBeginImageContextWithOptions(squareSize, false, 0)
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: squareSize)).addClip()
        image.draw(at: CGPoint(x: (squareSize.width - image.size.width) / 2, y: (squareSize.height - image.size.height) / 2))
        return UIGraphicsGetImageFromCurrentImageContext() ?? image
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true)
    }
    

}
