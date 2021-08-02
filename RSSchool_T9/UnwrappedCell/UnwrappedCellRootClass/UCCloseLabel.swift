//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 30.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class UCCloseLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "╳"
        textAlignment = .center
        textColor = UIColor.white
        backgroundColor = UIColor.black
        clipsToBounds = true
        font = UIFont.init(name: "HiraginoSans-W7", size: 24)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = UIColor.init(named: "#797979")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = UIColor.white
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = UIColor.white
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textColor = UIColor.white
    }
}
