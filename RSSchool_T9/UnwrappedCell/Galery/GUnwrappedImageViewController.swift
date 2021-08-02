//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class GUnwrappedImageViewController: UIViewController {
    var image: UIImage!
    weak var containerImageView: UIImageView!
    weak var scrollView: UIScrollView!
    weak var closeLabel: UCCloseLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        let scroll = UIScrollView.init()
        scroll.minimumZoomScale = 1
        scroll.maximumZoomScale = 3
        scroll.delegate = self
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        
        view.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            scroll.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scroll.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(disappearCloseLabel))
      
        scrollView.addGestureRecognizer(gesture)
        addCloseLabel()
        addImage()
        
      
       
    }
    
    convenience init(with image: UIImage) {
        self.init()
        self.image = image
    }
    
    private func addCloseLabel() {
        let close = UCCloseLabel.init()
        let gestureForClose = UITapGestureRecognizer.init(target: self, action: #selector(closeDescribing))
        
        close.addGestureRecognizer(gestureForClose)
        view.addSubview(close)
        closeLabel = close
       
        NSLayoutConstraint.activate([
            close.heightAnchor.constraint(equalToConstant: 40.0),
            close.widthAnchor.constraint(equalToConstant: 40.0),
            close.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            close.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)
        ])
    }
    
    @objc private func closeDescribing() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addImage() {
        let image = UIImageView.init(image: image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        containerImageView = image
    
        scrollView.addSubview(image)
        
        let screenSize = UIScreen.main.bounds.size
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: screenSize.width),
            image.heightAnchor.constraint(equalToConstant: screenSize.height/2)
        ])
    }
    
    @objc private func disappearCloseLabel() {
        if (closeLabel.isHidden) {
            closeLabel.isHidden = false
        } else {
            closeLabel.isHidden = true
        }
    }
   
}

extension GUnwrappedImageViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        containerImageView
    }
}
