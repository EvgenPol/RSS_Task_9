//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol CellForDataDelegate: AnyObject {
    func touchCell(from cell: CellForData)
}

class CellForData: UIView {
    weak var delegate: CellForDataDelegate?
    weak var imageView: ImageViewForCell!
    var data: ContentType!
    
    private var constraintsPortrait: [NSLayoutConstraint] = []
    
    static var id = 0
    
    private func createStuff() {
        if let data = self.data {
            switch data {
            case .gallery(let gallery):
                let imageView = ImageViewForCell.init(gallery.coverImage, gallery.title, gallery.type)
                configureImageView(imageView)
            case .story(let story):
                let imageView = ImageViewForCell.init(story.coverImage, story.title, story.type)
                configureImageView(imageView)
            }
        }
    }
    
    private func configureImageView(_ imageView: ImageViewForCell) {
        self.addSubview(imageView)
        self.imageView = imageView
        imageView.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
    }
        
    init() {
        super.init(frame: CGRect.zero)
       
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        data = FillingData.data[CellForData.id]
        CellForData.id += 1
        
        createConstraits()
        createStuff()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createConstraits() {
        let screenSize = UIScreen.main.bounds.size
        let screenHeight = max(screenSize.width, screenSize.height)
        let screenWidth = min(screenSize.width, screenSize.height)
    
        let heightLandscape =  self.heightAnchor.constraint(equalToConstant: screenWidth / 2.5)
        heightLandscape.priority = UILayoutPriority.init(998)
        heightLandscape.isActive = true
        
        let widthLandscape = self.widthAnchor.constraint(equalToConstant: (screenWidth / 2.5))
        widthLandscape.priority = UILayoutPriority.init(998)
        widthLandscape.isActive = true
        
        let heightPortrait =  self.heightAnchor.constraint(equalToConstant: screenHeight / 4)
        heightPortrait.priority = UILayoutPriority.init(999)
        heightPortrait.isActive = true
        
        let widthPortrait = self.widthAnchor.constraint(equalToConstant: ((screenHeight / 4) * 0.8) )
        widthPortrait.priority = UILayoutPriority.init(999)
        widthPortrait.isActive = true
        
        constraintsPortrait = [ heightPortrait, widthPortrait ]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let locationPoint = touches.first?.location(in: self) else { return }
        let viewPonit = self.imageView.convert(locationPoint, from: self)
        if self.imageView.point(inside: viewPonit, with: event) {
            delegate?.touchCell(from: self)
        }
    }
    
        
    func updateOrientation() {
        if (UIDevice.current.orientation == .portrait) {
            constraintsPortrait.forEach { $0.isActive = true }
        } else {
            constraintsPortrait.forEach { $0.isActive = false }
        }
        imageView.updateOrientation()
    }
    
    
}

