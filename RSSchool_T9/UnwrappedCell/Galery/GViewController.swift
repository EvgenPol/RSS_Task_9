//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GViewController: UCViewController {
    private var imageViews = [GImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageStackView()
    }
        
    
    private func addImageStackView() {
        for image in dataGallery.images {
            let view = GImageView.init(image: image, size: sizeImage ) //sizeImage from super class
            view.delegate = self
            imageViews += [view]
        }
        
        let stack = UIStackView.init(arrangedSubviews: imageViews)
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 98),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
}

//MARK: subscribing on the GImageViewDelegate
extension GViewController: GImageViewDelegate {
    func toucnImage(_ image: UIImage) {
        let vc = GUnwrappedImageViewController.init(with: image)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
