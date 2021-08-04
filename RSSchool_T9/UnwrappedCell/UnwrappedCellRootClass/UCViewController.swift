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
    weak var scrollView: UIScrollView!
    weak var imageView: UCMainImageView!
    private weak var closeLabel: UCCloseLabel!
    private weak var imageTypeView: UCImageTypeView!
    private weak var lineUnderImage: UIView!
    
    var sizeImage : CGSize!
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
        let screen = UIScreen.main.bounds.size
        let width = min(screen.height, screen.width)
        let sizeImage = CGSize.init(width: width * 0.9,
                                    height: (width * 0.9) / 0.75 )
        
        self.sizeImage = sizeImage
        view.backgroundColor = UIColor.black
        
        addScrollView()
        addCloseLabel()
        addImage()
        addImageType()
        addLineUnderImage()
       
        createConstraints()
    }
    
    //MARK: Stuff ↓
    
    private func addScrollView() {
        let scroll = UIScrollView.init(frame: view.bounds)
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        view.addSubview(scroll)
    }
    
    private func addCloseLabel() {
        let close = UCCloseLabel.init()
        let gestureForClose = UITapGestureRecognizer.init(target: self, action: #selector(closeDescribing))
        close.addGestureRecognizer(gestureForClose)
        scrollView.addSubview(close)
        closeLabel = close
    }
    
    private func addImage() {
        let img = dataStory?.coverImage ?? dataGallery?.coverImage ?? UIImage.init()
        let title = dataStory?.title ?? dataGallery?.title ?? "Error"
        let imageView = UCMainImageView.init(img: img, title: title, size: sizeImage)
        self.imageView = imageView
        scrollView.addSubview(imageView)
    }

    private func addImageType() {
        let type = dataStory?.type ?? dataGallery?.type ?? "Error"
        let typeView = UCImageTypeView.init(frame: CGRect.zero, text: type)
        imageTypeView = typeView
        scrollView.addSubview(typeView)
    }
    
    private func addLineUnderImage() {
        let line = UIView.init()
        line.layer.borderWidth = 1
        line.layer.borderColor = UIColor.white.cgColor
        line.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(line)
        lineUnderImage = line
    }
    
    
    //MARK: Constraints
    private func createConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            closeLabel.heightAnchor.constraint(equalToConstant: 40.0),
            closeLabel.widthAnchor.constraint(equalToConstant: 40.0),
            closeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            closeLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
                  
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: sizeImage.height),
            imageView.widthAnchor.constraint(equalToConstant: sizeImage.width),
                 
            imageTypeView.widthAnchor.constraint(equalToConstant: 122),
            imageTypeView.heightAnchor.constraint(equalToConstant: 44),
            imageTypeView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageTypeView.centerYAnchor.constraint(equalTo: imageView.bottomAnchor),
                        
            lineUnderImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100),
            lineUnderImage.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 58),
            lineUnderImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -100),
            lineUnderImage.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    //selector
    @objc private func closeDescribing() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: subscribe on the UIScrollViewDelegate
extension UCViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
        }
    }
}
