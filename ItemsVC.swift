//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsVC: UIViewController {
    var arrayStackView: [UIStackView] = []
    weak var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView?.contentSize.width = self.view.bounds.width
        createStackViews()
        
    }
    
    override func loadView() {
        super.loadView()
        let scroll = UIScrollView.init(frame: self.view.bounds)
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        self.view.addSubview(scroll)
        self.view.backgroundColor = UIColor.white
        
        NSLayoutConstraint.activate([
            scroll.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            scroll.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    private func createStackViews() {
        var arrayViewForStackNumberOne = [CellForData]()
        var arrayViewForStackNumberTwo = [CellForData]()
        
        for _ in 1...4 {
            let cellOne = CellForData.init()
            let cellTwo = CellForData.init()
            
            cellOne.delegate = self
            cellTwo.delegate = self
            
            arrayViewForStackNumberOne.append(cellOne)
            arrayViewForStackNumberTwo.append(cellTwo)
        }
        
        let stackViewOne = UIStackView.init(arrangedSubviews: arrayViewForStackNumberOne)
        let stackViewTwo = UIStackView.init(arrangedSubviews: arrayViewForStackNumberTwo)
        
        self.arrayStackView = [stackViewOne, stackViewTwo]
        
        for stack in arrayStackView {
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 30
            self.scrollView?.addSubview(stack)
        }
        
        NSLayoutConstraint.activate([
            stackViewOne.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0),
            stackViewOne.topAnchor.constraint(equalTo: scrollView!.topAnchor, constant: 8.0),
            stackViewOne.bottomAnchor.constraint(equalTo: scrollView!.bottomAnchor, constant: -50.0),
            
            stackViewTwo.topAnchor.constraint(equalTo: scrollView!.topAnchor, constant: 8.0),
            stackViewTwo.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20.0),
            stackViewTwo.bottomAnchor.constraint(equalTo: scrollView!.bottomAnchor, constant: -50.0),
        ])
    }

   

}

extension ItemsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
        }
    }
}

extension ItemsVC: CellForDataDelegate {
    func touchCell(from cell: CellForData) {
        let describingCellViewController: DescribingCellVC!
        switch cell.data {
        case .gallery:
            describingCellViewController = StoryVC.init(data: cell.data, colorPaths: UIColor.init(named: "#F3AF22")!, turnedTimer: true)
        case .story:
            describingCellViewController = StoryVC.init(data: cell.data, colorPaths: UIColor.init(named: "#F3AF22")!, turnedTimer: true)
        case .none:
            describingCellViewController = DescribingCellVC.init(data: cell.data)
        }
       
        
        describingCellViewController.modalPresentationStyle = .fullScreen
        present(describingCellViewController, animated: true, completion: nil)
      
    }
    
}
