//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 29.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class DescribingCellVC: UIViewController {
    weak var scrollView: UIScrollView!
    weak var imageView: MyImageViewMain!
    var dataStory: Story?
    var dataGallery: Gallery?
  
    convenience init(data : ContentType) {
        self.init()
        switch data {
            case .gallery(let gallery): dataGallery = gallery
            case .story(let story): dataStory = story
        }
    }
 
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.black
        
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
            scroll.leftAnchor.constraint(equalTo: view.leftAnchor),
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.rightAnchor.constraint(equalTo: view.rightAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addCloseLabel() {
        let close = UILabel.init()
        close.text = "╳"
        close.textAlignment = .center
        close.textColor = UIColor.white
        close.font = UIFont.init(name: "HiraginoSans-W7", size: 24)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.layer.cornerRadius = 20
        close.layer.borderColor = UIColor.white.cgColor
        close.layer.borderWidth = 1.0
        
        let gestureForClose = UITapGestureRecognizer.init(target: self, action: #selector(closeDescribing))
        close.addGestureRecognizer(gestureForClose)
        close.isUserInteractionEnabled = true
        
        scrollView.addSubview(close)
       
        NSLayoutConstraint.activate([
            close.heightAnchor.constraint(equalToConstant: 40.0),
            close.widthAnchor.constraint(equalToConstant: 40.0),
            close.topAnchor.constraint(equalTo: scrollView.topAnchor),
            close.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25)
        ])
    }
    
    private func addImage() {
        let img = dataStory?.coverImage ?? dataGallery?.coverImage ?? UIImage.init()
        let title = dataStory?.title ?? dataGallery?.title ?? "Error"
        
        let imageView = MyImageViewMain.init(img: img, title: title)
        scrollView?.addSubview(imageView)
        self.imageView = imageView
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: scrollView!.leftAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: scrollView!.topAnchor, constant: 70),
            imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 500),
        ])
    }

    private func addImageType() {
        let type = dataStory?.type ?? dataGallery?.type ?? "Error"
        
        let subtitle = UILabel.init()
        subtitle.text = type
        subtitle.font = UIFont.init(name: "Rockwell-Bold", size: 24)
        subtitle.textColor = UIColor.white
        subtitle.backgroundColor = UIColor.black
        subtitle.textAlignment = .center
        subtitle.layer.cornerRadius = 8
        subtitle.layer.borderWidth = 1
        subtitle.layer.borderColor = UIColor.white.cgColor
        subtitle.translatesAutoresizingMaskIntoConstraints = false

        scrollView?.addSubview(subtitle)
        
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

extension DescribingCellVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
        }
    }
}
