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
    
    static var id = 0
    
    private func createData (id: Int) {
        switch id {
        case 0: data = FillingData.data[0]
        case 1: data = FillingData.data[1]
        case 2: data = FillingData.data[2]
        case 3: data = FillingData.data[3]
        case 4: data = FillingData.data[4]
        case 5: data = FillingData.data[5]
        case 6: data = FillingData.data[6]
        case 7: data = FillingData.data[7]
        default: data = FillingData.data[0]
        }
    }
    
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
    
        NSLayoutConstraint.activate([
//            imageView.widthAnchor.constraint(equalToConstant: 163),
//            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        imageView.isUserInteractionEnabled = true
    }
    
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 220).isActive = true
        self.widthAnchor.constraint(equalToConstant: 179).isActive = true
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
//        self.clipsToBounds = false
        createData(id: CellForData.id)
        CellForData.id += 1
        
        createStuff()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let locationPoint = touches.first?.location(in: self) else { return }
        let viewPonit = self.imageView.convert(locationPoint, from: self)
        if self.imageView.point(inside: viewPonit, with: event) {
            delegate?.touchCell(from: self)
        }
    }
    
}

