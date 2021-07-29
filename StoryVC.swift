//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class StoryVC: DescribingCellVC {
    var colorForPaths: UIColor!
    var turnedTimer: Bool!
    
    convenience init(data : ContentType, colorPaths: UIColor, turnedTimer: Bool) {
        self.init()
        colorForPaths = colorPaths
        self.turnedTimer = turnedTimer
        switch data {
            case .gallery(let gallery): dataGallery = gallery
            case .story(let story): dataStory = story
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addPaths()
        addStoryLabel()
        
    }

    private func addStoryLabel() {
        
        let storyText = self.dataStory?.text ?? "Error"
        
        let attributedString = NSMutableAttributedString(string: storyText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .left
        paragraphStyle.maximumLineHeight = 29
        paragraphStyle.minimumLineHeight = 29

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        let containerView = UIView.init()
        let storyLabel = UILabel.init()
        storyLabel.attributedText = attributedString
        storyLabel.textColor = UIColor.white
        storyLabel.numberOfLines = 0
        
        storyLabel.font = UIFont.init(name: "Rockwell", size: 24)
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(storyLabel)
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 20),
            containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 238),
            containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            
            storyLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor , constant: 30),
            storyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            storyLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -40),
            storyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
        ])
    }
    
    private func addPaths() {
        let viewOne = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 74, height: 61))
        let viewTwo = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 74, height: 61))
        
        
        viewOne.translatesAutoresizingMaskIntoConstraints = false
        viewTwo.translatesAutoresizingMaskIntoConstraints = false
        viewOne.backgroundColor = UIColor.black
        viewTwo.backgroundColor = UIColor.black
        
        let shapeLayerOne = CAShapeLayer.init(layer: viewOne.layer)
        let shapeLayerTwo = CAShapeLayer.init(layer: viewTwo.layer)
        
        shapeLayerOne.path = dataStory?.paths[0]
        shapeLayerTwo.path = dataStory?.paths[1]
        
        shapeLayerOne.strokeColor = UIColor.yellow.cgColor
        shapeLayerTwo.strokeColor = UIColor.yellow.cgColor
        
        shapeLayerOne.borderWidth = 0.5
        shapeLayerOne.borderColor = UIColor.yellow.cgColor
        shapeLayerTwo.borderWidth = 0.5
        shapeLayerTwo.borderColor = UIColor.yellow.cgColor
        
        shapeLayerOne.strokeEnd = 1
        shapeLayerTwo.strokeEnd = 1
        viewOne.layer.addSublayer(shapeLayerOne)
        viewTwo.layer.addSublayer(shapeLayerTwo)
        
        scrollView.addSubview(viewOne)
        scrollView.addSubview(viewTwo)
        
        NSLayoutConstraint.activate([
            viewOne.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 71),
            viewOne.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 116),
            viewOne.rightAnchor.constraint(equalTo: viewTwo.leftAnchor, constant: -102),
            viewOne.widthAnchor.constraint(equalToConstant: 74),
            viewOne.heightAnchor.constraint(equalToConstant: 61),
            
            
            viewTwo.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 116),
            viewTwo.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -95),
//            viewTwo.widthAnchor.constraint(equalToConstant: 74),
            viewTwo.heightAnchor.constraint(equalToConstant: 61),
        ])
    }
}
