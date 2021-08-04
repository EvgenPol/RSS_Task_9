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
    private weak var scrollView: UIScrollView!
    private weak var closeLabel: UCCloseLabel!
    private weak var imageView: UIImageView!
    private weak var image: UIImage!
    
    convenience init(with image: UIImage) {
        self.init()
        self.image = image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black

        addScrollView()
        addCloseLabel()
        addImage()
        createConstraints()
    }
    
    //MARK: Stuff ↓
    
    private func addScrollView() {
        let scroll = UIScrollView.init()
        scroll.minimumZoomScale = 1
        scroll.maximumZoomScale = 3
        scroll.delegate = self
        scroll.alwaysBounceVertical = false
        scroll.alwaysBounceHorizontal = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        view.addSubview(scroll)
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(disappearCloseLabel))
        scrollView.addGestureRecognizer(gesture)
    }
    
    private func addCloseLabel() {
        let close = UCCloseLabel.init()
        closeLabel = close
        view.addSubview(closeLabel)
        
        let gestureForClose = UITapGestureRecognizer.init(target: self, action: #selector(closeDescribing))
        closeLabel.addGestureRecognizer(gestureForClose)
    }
    
    private func addImage() {
        let image = UIImageView.init(image: image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        imageView = image
        scrollView.addSubview(imageView)
    }
    
    //MARK: Constraints
    private func createConstraints() {
        let screenSize = UIScreen.main.bounds.size
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            closeLabel.heightAnchor.constraint(equalToConstant: 40.0),
            closeLabel.widthAnchor.constraint(equalToConstant: 40.0),
            closeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            closeLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: screenSize.width - 16),
            imageView.heightAnchor.constraint(equalToConstant: screenSize.height/2 - 16)
        ])
    }
    
    //selector to hide closeLabel
    @objc private func disappearCloseLabel() {
        if (closeLabel.isHidden) {
            closeLabel.isHidden = false
        } else {
            closeLabel.isHidden = true
        }
    }
    
    //selector for dismis
    @objc private func closeDescribing() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: subscribing on the UIScrollViewDelegate
extension GUnwrappedImageViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
