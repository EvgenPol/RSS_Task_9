//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class PathView: UIView {
    
    var shapeLayer: CAShapeLayer?
    var timer: Timer?
    
    convenience init(_ path: CGPath,_ color: CGColor) {
        self.init()
        contentMode = .redraw
        shapeLayer = CAShapeLayer.init(layer: self.layer)
        shapeLayer?.path = path
        shapeLayer?.strokeColor = color
        shapeLayer?.strokeEnd = 0.0
        layer.addSublayer(shapeLayer!)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func appearPath() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0167, repeats: true) { [unowned self] timer in
            shapeLayer?.strokeEnd += 1.0 / (60.0 * 3.0)
            shapeLayer!.strokeEnd >= 1.0 ? (timer.invalidate()) : ()
        }
    }
    
    func disappearPath() {
        timer?.invalidate()
        timer = nil
        shapeLayer?.strokeEnd = 0
    }
}
