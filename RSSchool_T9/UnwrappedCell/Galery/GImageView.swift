//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol GImageViewDelegate: AnyObject {
    func toucnImage(_ image: UIImage)
}

class GImageView: UIView {
    private weak var image: UIImage!
    weak var delegate: GImageViewDelegate?
    
    convenience init(image: UIImage, size: CGSize) {
        self.init()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        
        self.image = image
        let imageView = UIImageView.init(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            heightAnchor.constraint(equalToConstant: size.height),
            widthAnchor.constraint(equalToConstant: size.width)
        ])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.toucnImage(image)
    }
    
}
