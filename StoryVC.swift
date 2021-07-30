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
    
    weak var pathsScrollView: PathsScrollView!
    
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
        
        addPathsScrollView()
        addStoryLabel()
    
        
    }

    private func addStoryLabel() {
        let storyText = self.dataStory?.text ?? "Error"
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .left
        paragraphStyle.maximumLineHeight = 29
        paragraphStyle.minimumLineHeight = 29

        let attributedString = NSMutableAttributedString(string: storyText)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        let storyLabel = UILabel.init()
        storyLabel.attributedText = attributedString
        storyLabel.textColor = UIColor.white
        storyLabel.numberOfLines = 0
        storyLabel.font = UIFont.init(name: "Rockwell", size: 24)
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView.init()
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
    
    private func addPathsScrollView() {
        let scroll = PathsScrollView.init(paths: dataStory!.paths, color: colorForPaths.cgColor, turnedTimer: turnedTimer)
        self.pathsScrollView = scroll
        self.scrollView.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 116),
            scroll.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scroll.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.gradient.frame = imageView.bounds
        
    }
    
}
