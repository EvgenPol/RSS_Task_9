//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class UCViewController: UIViewController {
    var sizeImage : CGSize!
    weak var scrollView: UIScrollView!
    weak var imageView: UCMainImageView!
    var dataStory: Story!
    var dataGallery: Gallery!
  
    convenience init(data : ContentType) {
        self.init()
        switch data {
            case .gallery(let gallery): dataGallery = gallery
            case .story(let story): dataStory = story
        }
    }
 
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black
        
        let screen = UIScreen.main.bounds.size
        let width = min(screen.height, screen.width)
        let sizeImage = CGSize.init(width: width * 0.9,
                                    height: (width * 0.9) / 0.75 )
        self.sizeImage = sizeImage
        
        addScrollView()
        addCloseLabel()
        addImage()
        addImageType()
        addLineUnderImage()
       
    }
    
   
    
    private func addScrollView() {
        let scroll = UIScrollView.init(frame: self.view.bounds)
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        self.view.addSubview(scroll)
        NSLayoutConstraint.activate([
            scroll.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addCloseLabel() {
        let close = UCCloseLabel.init()
        let gestureForClose = UITapGestureRecognizer.init(target: self, action: #selector(closeDescribing))
        
        close.addGestureRecognizer(gestureForClose)
        scrollView.addSubview(close)
       
        NSLayoutConstraint.activate([
            close.heightAnchor.constraint(equalToConstant: 40.0),
            close.widthAnchor.constraint(equalToConstant: 40.0),
            close.topAnchor.constraint(equalTo: scrollView.topAnchor),
            close.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)
        ])
    }
    
    private func addImage() {
        let img = dataStory?.coverImage ?? dataGallery?.coverImage ?? UIImage.init()
        let title = dataStory?.title ?? dataGallery?.title ?? "Error"
        
        let imageView = UCMainImageView.init(img: img, title: title, size: sizeImage)
        
        self.imageView = imageView
        
        scrollView?.addSubview(imageView)
      
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: sizeImage.height),
            imageView.widthAnchor.constraint(equalToConstant: sizeImage.width),
        ])
        
        
    }

    private func addImageType() {
        let type = dataStory?.type ?? dataGallery?.type ?? "Error"
        let subtitle = UCTitleMainImage.init(frame: CGRect.zero, text: type)
        
        scrollView.addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            subtitle.widthAnchor.constraint(equalToConstant: 122),
            subtitle.heightAnchor.constraint(equalToConstant: 44),
            subtitle.centerXAnchor.constraint(equalTo: scrollView!.centerXAnchor),
            subtitle.centerYAnchor.constraint(equalTo: imageView!.bottomAnchor)
        ])
    }
    
    private func addLineUnderImage() {
        let line = UIView.init()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.white.cgColor
        line.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(line)
        
        NSLayoutConstraint.activate([
            line.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100),
            line.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 58),
            line.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc private func closeDescribing() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UCViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
        }
    }
}
