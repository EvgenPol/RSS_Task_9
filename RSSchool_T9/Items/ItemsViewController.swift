//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Евгений Полюбин
// On: 28.07.2021
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class ItemsViewController: UIViewController {
    private weak var scrollView: UIScrollView!
    private var arrayStackView: [UIStackView] = []
    private var arrayCellView: [CellForData] = []
    
    private var stackOneConstraintsPortrait: [NSLayoutConstraint] = []
    private var stackTwoConstraintsPortrait: [NSLayoutConstraint] = []
    private var stackOneConstraintsLandscape: [NSLayoutConstraint] = []
    private var stackTwoConstraintsLandscape: [NSLayoutConstraint] = []
    
    private var startOrientation = UIDeviceOrientation.unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scroll = UIScrollView.init(frame: view.bounds)
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scrollView = scroll
        
        view.addSubview(scroll)
        view.backgroundColor = UIColor.white
    
        createStackViews()
        createConstraints()
    }

    //MARK: Stuff
    private func createStackViews() {
        var arrayViewForStackNumberOne = [CellForData]()
        var arrayViewForStackNumberTwo = [CellForData]()
        
        for _ in 1...(FillingData.data.count / 2) {
            let cellOne = CellForData.init()
            let cellTwo = CellForData.init()
            cellOne.delegate = self
            cellTwo.delegate = self
            arrayViewForStackNumberOne.append(cellOne)
            arrayViewForStackNumberTwo.append(cellTwo)
            arrayCellView.append(cellOne)
            arrayCellView.append(cellTwo)
        }
        
        let stackViewOne = UIStackView.init(arrangedSubviews: arrayViewForStackNumberOne)
        let stackViewTwo = UIStackView.init(arrangedSubviews: arrayViewForStackNumberTwo)
        
        arrayStackView = [stackViewOne, stackViewTwo]
        
        for stack in arrayStackView {
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.spacing = 30
            self.scrollView.addSubview(stack)
        }
    }
    
    //MARK: Constraints
    private func createConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    
        stackOneConstraintsPortrait = [
            arrayStackView[0].leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            arrayStackView[0].topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0),
            arrayStackView[0].bottomAnchor.constraint(equalTo: scrollView!.bottomAnchor, constant: -50.0)
        ]
        stackTwoConstraintsPortrait = [
            arrayStackView[1].topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0),
            arrayStackView[1].rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            arrayStackView[1].bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50.0)
        ]
        stackOneConstraintsLandscape = [
            arrayStackView[0].leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            arrayStackView[0].topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            arrayStackView[0].rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            
        ]
        stackTwoConstraintsLandscape = [
            arrayStackView[1].leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            arrayStackView[1].bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            arrayStackView[1].rightAnchor.constraint(equalTo: scrollView.rightAnchor),
        ]
    }
    
    //MARK: response to changing the screen orientation ↓
    
    private func updateOrientation() {
        if UIDevice.current.orientation == .portrait {
            
            stackOneConstraintsLandscape.forEach { $0.isActive = false }
            stackTwoConstraintsLandscape.forEach { $0.isActive = false }
            
            arrayStackView.forEach { $0.axis = .vertical }
            scrollView.showsVerticalScrollIndicator = true
            scrollView.showsHorizontalScrollIndicator = false
            
            stackOneConstraintsPortrait.forEach { $0.isActive = true }
            stackTwoConstraintsPortrait.forEach { $0.isActive = true }

        } else {
            
            stackOneConstraintsPortrait.forEach { $0.isActive = false }
            stackTwoConstraintsPortrait.forEach { $0.isActive = false }
            
            arrayStackView.forEach { $0.axis = .horizontal }
            scrollView.showsVerticalScrollIndicator = false
            scrollView.showsHorizontalScrollIndicator = true
            
            stackOneConstraintsLandscape.forEach { $0.isActive = true }
            stackTwoConstraintsLandscape.forEach { $0.isActive = true }
        }
    }
    
    override func viewWillLayoutSubviews() {
        arrayCellView.forEach { $0.updateOrientation() }
        updateOrientation()
        startOrientation = UIDevice.current.orientation
    }
}


//MARK: subscribing on the CellForDataDelegate
extension ItemsViewController: CellForDataDelegate {
    
    func touchCell(from cell: CellForData) {
        let unwrappedCellVC: UCViewController!
        switch cell.data {
        
        case .gallery:
            unwrappedCellVC = GViewController.init(data: cell.data)
            
        case .story:
            let settings = (self.tabBarController as? TabBarVC)?.settingController
            let color = settings?.listOfColor?.selectedColor
            
            if (settings?.isViewLoaded == true) {
                unwrappedCellVC = SViewController.init(data: cell.data,
                                                       colorForPaths: color,
                                                       turnedTimer: settings?.turnedTimer,
                                                       startOrientation)
            } else {
                unwrappedCellVC = SViewController.init(data: cell.data,
                                                       colorForPaths: color,
                                                       turnedTimer: true,
                                                       startOrientation)
            }
        }
        unwrappedCellVC.modalPresentationStyle = .fullScreen
        present(unwrappedCellVC, animated: true, completion: nil)
    }
}
