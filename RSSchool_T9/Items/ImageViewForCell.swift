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
    private weak var gradient : CAGradientLayer!
    private weak var titleLabel : UILabel!
    private weak var subtitleLabel : UILabel!
        
    init(_ img: UIImage, _ title: String, _ type: String) {
        super.init(image: img)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        clipsToBounds = true
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        addGradiend()
        addLabels(title, type)
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Stuff ↓
    
    private func addLabels(_ title: String, _ type: String) {
        let titleLabel = UILabel.init()
        let subtitleLabel = UILabel.init()
    
        titleLabel.text = title
        titleLabel.font = UIFont.init(name: "Rockwell", size: 16)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.text = type
        subtitleLabel.font = UIFont.init(name: "Rockwell", size: 12)
        subtitleLabel.textColor = UIColor.init(named: "#B6B6B6")
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
    }
    
    private func addGradiend() {
        let colorTop = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBottom =  UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        let gradient = CAGradientLayer()
        
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.65, 0.9]
        
        self.layer.addSublayer(gradient)
        self.gradient = gradient
    }
    
    //MARK: Constraints
    private func createConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    //MARK: Response to changing the screen orientation
     func updateOrientation() {
        let height = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        
        if UIDevice.current.orientation.isPortrait {
            gradient.frame.size = CGSize.init(width: (height/4) * 0.8, height: height / 4)
        } else {
            gradient.frame.size = CGSize.init(width: height / 3 * 0.8, height: height / 3)
        }
    }
}
