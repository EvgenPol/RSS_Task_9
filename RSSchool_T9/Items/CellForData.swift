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
    let data: ContentType
    weak var delegate: CellForDataDelegate?
    private weak var imageView: ImageViewForCell!
    private var constraintsPortrait: [NSLayoutConstraint] = []
    
    static var id = 0
    
    init() {
        data = FillingData.data[CellForData.id]
        CellForData.id += 1
        
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 18
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        createStuff()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Creating the cover image, title, type for cell
    private func createStuff() {
        
        func configureImageView(_ imageView: ImageViewForCell) {
            self.addSubview(imageView)
            self.imageView = imageView
            imageView.isUserInteractionEnabled = true
        } // - Nested function for imageView
        
        switch data {
        
        case .gallery(let gallery):
            let imageView = ImageViewForCell.init(gallery.coverImage, gallery.title, gallery.type)
            configureImageView(imageView)
            
        case .story(let story):
            let imageView = ImageViewForCell.init(story.coverImage, story.title, story.type)
            configureImageView(imageView)
        }
    }
    
    //MARK: Constraints
    private func createConstraints() {
        let screenSize = UIScreen.main.bounds.size
        let screenHeight = max(screenSize.width, screenSize.height)
    
        let heightLandscape =  heightAnchor.constraint(equalToConstant: screenHeight / 3)
        heightLandscape.priority = UILayoutPriority.init(998)
        
        let widthLandscape = widthAnchor.constraint(equalToConstant: (screenHeight / 3) * 0.8)
        widthLandscape.priority = UILayoutPriority.init(998)
        
        let heightPortrait =  heightAnchor.constraint(equalToConstant: screenHeight / 4)
        heightPortrait.priority = UILayoutPriority.init(999)
        
        let widthPortrait = widthAnchor.constraint(equalToConstant: ((screenHeight / 4) * 0.8) )
        widthPortrait.priority = UILayoutPriority.init(999)
        
        constraintsPortrait = [ heightPortrait, widthPortrait ]
        
        NSLayoutConstraint.activate([
            widthPortrait, heightPortrait, widthLandscape, heightLandscape,
            
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Response to changing the screen orientation
    func updateOrientation() {
        if (UIDevice.current.orientation == .portrait) {
            constraintsPortrait.forEach { $0.isActive = true }
        } else {
            constraintsPortrait.forEach { $0.isActive = false }
        }
        imageView.updateOrientation()
    }
    
    
    //MARK: Response to the touch of the image
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let locationPoint = touches.first?.location(in: self) else { return }
        let viewPonit = imageView.convert(locationPoint, from: self)
        
        if imageView.point(inside: viewPonit, with: event) {
            delegate?.touchCell(from: self)
        }
    }
}

