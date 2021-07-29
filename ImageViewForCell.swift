//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ImageViewForCell: UIImageView {
   
    
    init(_ img: UIImage, _ title: String, _ type: String) {
        
        super.init(image: img)
        
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        clipsToBounds = true
        
        addGradiend()
        addLabels(title, type)
        
    }
    
    private func addLabels(_ title: String, _ type: String) {
        let titleLabel = UILabel.init()
        let subtitleLabel = UILabel.init()
    
        titleLabel.text = title
        subtitleLabel.text = type
        
        titleLabel.font = UIFont.init(name: "Rockwell", size: 16)
        titleLabel.textColor = UIColor.white
        
        subtitleLabel.font = UIFont.init(name: "Rockwell", size: 12)
        subtitleLabel.textColor = UIColor.init(named: "#B6B6B6")
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 151),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            subtitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 173),
            subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15)
        ])
        
    }
    
    private func addGradiend() {
        let colorTop = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBottom =  UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradient = CAGradientLayer()
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0, 0.4]
        gradient.frame = self.bounds
        gradient.frame.origin.y += 140
        gradient.frame.size.height = 140
        gradient.frame.size.width = 163
       
        self.layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
