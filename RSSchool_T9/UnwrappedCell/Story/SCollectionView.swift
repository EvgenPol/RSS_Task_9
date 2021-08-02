//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 02.08.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SCollectionView: UICollectionView {
    let data : [CGPath]
    let color : UIColor
    let timer : Bool
    var widthCollectionAnchor : NSLayoutConstraint!
    
    init (with paths: [CGPath],_ color : UIColor, and timer: Bool) {
        self.data = paths
        self.color = color
        self.timer = timer
        
        let width = min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 100
        layout.itemSize = CGSize.init(width: 75, height: 70)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: width/6, bottom: 0, right: width/6)
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        register(SCollectionViewCell.self, forCellWithReuseIdentifier: "Path")
        
        let widthItem = data.count * 75
        let widthSpacingLine = (data.count - 1) * 100
        let widthSpaceInset = (width / 6) * 2
        widthCollectionAnchor =  widthAnchor.constraint(equalToConstant: CGFloat(widthItem + widthSpacingLine) + widthSpaceInset)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}

extension SCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "Path", for: indexPath) as! SCollectionViewCell
        cell.shapeLayer.strokeColor = color.cgColor
        cell.shapeLayer.path = data[indexPath.row]
        
        if (timer) {
            cell.shapeLayer.strokeEnd = 0.0
            cell.animation()
        }
    
        return cell
    }
    
   
    
    
}
