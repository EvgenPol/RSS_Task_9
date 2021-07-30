//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class PathsScrollView: UIScrollView {
    var pathViews: [PathView] = []
    var turnedTimer: Bool!

    convenience init (paths: [CGPath], color: CGColor, turnedTimer: Bool) {
        self.init()
        self.turnedTimer = turnedTimer
        
        delegate = self
        
        for path in paths {
            let view = PathView.init(path, color)
            self.addSubview(view)
            pathViews += [view]
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 75).isActive = true
        addViewsConstraints()
        
        if (turnedTimer) {
            pathViews[0].appearPath()
            pathViews[1].appearPath()
        } else {
            pathViews.forEach { view in
                view.shapeLayer?.strokeEnd = 1.0
            }
        }
    }
    
    
    private func addViewsConstraints(){
        for i in pathViews.indices {
            pathViews[i].widthAnchor.constraint(equalToConstant: 75).isActive = true
            pathViews[i].heightAnchor.constraint(equalToConstant: 70).isActive = true
            pathViews[i].topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            pathViews[i].bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            switch i {
            case 0:
                pathViews[i].leftAnchor.constraint(equalTo: self.leftAnchor, constant: 71).isActive = true
               
            case 1:
                pathViews[i].leftAnchor.constraint(equalTo: pathViews[0].rightAnchor, constant: 102).isActive = true
                if (pathViews.count == 2) {
                    pathViews[i].rightAnchor.constraint(equalTo: self.rightAnchor, constant: -95).isActive = true
                }
            case 2:
                pathViews[i].leftAnchor.constraint(equalTo: pathViews[1].rightAnchor, constant: 102).isActive = true
                if (pathViews.count == 3) {
                    pathViews[i].rightAnchor.constraint(equalTo: self.rightAnchor, constant: -95).isActive = true
                }
            case 3:
                pathViews[i].leftAnchor.constraint(equalTo: pathViews[2].rightAnchor, constant: 102).isActive = true
                pathViews[i].rightAnchor.constraint(equalTo: self.rightAnchor, constant: -95).isActive = true
            default:
                break
            }
        }
    }
    
    deinit {
        pathViews.forEach { view in
            view.timer?.invalidate()
        }
    }
}

extension PathsScrollView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (turnedTimer) {
            var visibleRect = CGRect.zero
            visibleRect.origin = scrollView.contentOffset
            visibleRect.size = scrollView.bounds.size
            visibleRect.origin.x += 5
            visibleRect.size.width -= 5
            
            pathViews.forEach { view in
                let layer = view.layer.sublayers?.first as? CAShapeLayer
                if visibleRect.intersects(view.frame) && layer!.strokeEnd == 0 {
                    view.appearPath()
                } else  if !visibleRect.intersects(view.frame) && layer!.strokeEnd != 0  {
                    view.disappearPath()
                }
            }
        }
    }
}
    

