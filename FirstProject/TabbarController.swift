//
//  TabBarController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit

extension TabbarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}

class TabbarController: UITabBarController {
    
    var upperLineView: UIView!
    let spacing: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.cornerRadius = 20
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                  self.addTabbarIndicatorView(index: 0, isFirstTime: true)
              }
        
        // Do any additional setup after loading the view.
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime{
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.maxY + 8, width: tabView.frame.size.width - spacing * 2, height: 4))
        upperLineView.backgroundColor = .orange
        tabBar.addSubview(upperLineView)
    }
}

