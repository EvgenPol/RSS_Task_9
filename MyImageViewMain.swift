//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class MyImageViewMain: UIImageView {
    
    init(img: UIImage, title: String) {
        super.init(image: img)
         
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
         
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
         
        clipsToBounds = true
        addGradiend()
        addImageTitle(title)
     }
     
      func addImageTitle(_ title: String) {
        let attributedString = NSMutableAttributedString(string: "")
        
        if title == "Coffee\n" {
            attributedString.append(NSAttributedString(string: "Coffee"))
        } else {
            attributedString.append(NSAttributedString(string: title))
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .left
        paragraphStyle.maximumLineHeight = 58
        paragraphStyle.minimumLineHeight = 58

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        let titleLabel = UILabel.init()
        titleLabel.clipsToBounds = false
        titleLabel.font = UIFont.init(name: "Rockwell", size: 48)
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = attributedString
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
     
        self.addSubview(titleLabel)
       
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 120)
        ])
     }
     
   private func addGradiend() {
        let colorTop = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBottom =  UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradient = CAGradientLayer()

        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0, 0.95]

        gradient.frame = self.bounds
        
        gradient.frame.origin = CGPoint.init(x: 0, y: 250)
        gradient.frame.size = CGSize.init(width: 374, height: 250)
        

        self.layer.addSublayer(gradient)
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }

}
