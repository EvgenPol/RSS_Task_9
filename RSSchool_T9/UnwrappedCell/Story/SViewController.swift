//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SViewController: UCViewController {
    var colorPaths: UIColor!
    var turnedTimer: Bool!
    
    weak var pathsCollection: SCollectionView!
    var constraintCollectionPortrait : [NSLayoutConstraint] = []
    var constraintCollectionLandscape : [NSLayoutConstraint] = []
    
    var originOrientaton: UIDeviceOrientation!
    
    convenience init(data : ContentType, colorForPaths: String?, turnedTimer: Bool?, _ orientation: UIDeviceOrientation ) {
        self.init()
        originOrientaton = orientation
    
        if let color = colorForPaths {
            self.colorPaths = UIColor.init(named: color)
        } else {
            self.colorPaths = UIColor.init(named: "#f3af22")
        }
        
        self.turnedTimer = turnedTimer
        
        switch data {
            case .gallery(let gallery): dataGallery = gallery
            case .story(let story): dataStory = story
        }
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addPathsCollection()
        addStoryLabel()
        newnOrientation(originOrientaton)
    }
    
    private func addStoryLabel() {
        let storyText = self.dataStory?.text ?? "Error"
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
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
            containerView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
            containerView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 238),
            containerView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            
            storyLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor , constant: 30),
            storyLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            storyLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -40),
            storyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30),
        ])
    }
    
    private func addPathsCollection() {
        let collection = SCollectionView.init(with: dataStory.paths, colorPaths, and: turnedTimer)
        pathsCollection = collection
        scrollView.addSubview(collection)
        
        let rightConstraintPortraite = collection.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        let leftConstraintPortraite = collection.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)
        constraintCollectionPortrait = [rightConstraintPortraite, leftConstraintPortraite]
        
        let centerConstraintLandscape =  collection.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        constraintCollectionLandscape = [centerConstraintLandscape, pathsCollection.widthCollectionAnchor]
        
        collection.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 116).isActive = true
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        newnOrientation(nil)
    }
    
    
    private func newnOrientation (_ orientation : UIDeviceOrientation?) {
        let orient = orientation ?? UIDevice.current.orientation
        if (orient.isPortrait) {
            constraintCollectionLandscape.forEach { $0.isActive = false }
            constraintCollectionPortrait.forEach { $0.isActive = true }
        } else if (orient.isLandscape)  {
            constraintCollectionPortrait.forEach { $0.isActive = false }
            constraintCollectionLandscape.forEach { $0.isActive = true }
        }
    }
   
}
