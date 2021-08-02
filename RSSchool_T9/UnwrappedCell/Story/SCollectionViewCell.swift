//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 02.08.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SCollectionViewCell: UICollectionViewCell {
    let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        shapeLayer.removeAllAnimations()
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval.init(3)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shapeLayer.add(animation, forKey: "strokeEnd")
    }
  
}
