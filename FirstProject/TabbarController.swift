//
//  TabBarController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

class TabbarController: UITabBarController , UITabBarControllerDelegate {
    
    struct XPosition{
        var minX = 0.0
        var maxX = 0.0
    }
    
    var BarItemsPosition : [XPosition] = []
    var upperLineView: UIView!
    let spacing: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.cornerRadius = 20
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                  self.addTabbarIndicatorView(index: 0, isFirstTime: true)
              }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTakeScreenshot(notification:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
        for i in 0..<self.tabBar.items!.count{
            self.tabBar.items![i].imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            
            if let view = self.tabBar.items?[i].value(forKey: "view") as? UIView{
                var position = XPosition()
                position.maxX = view.frame.maxX
                position.minX = view.frame.minX
                BarItemsPosition.append(position)

            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let position = touch.location(in: tabBar)
            for i in 0..<BarItemsPosition.count{
                if position.x >= BarItemsPosition[i].minX && position.x <= BarItemsPosition[i].maxX && position.y > 0 {
                    self.selectedIndex = i
                    self.tabBar(self.tabBar, didSelect: self.tabBar.items![i])
                    break
                }
            }
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    @objc func didTakeScreenshot(notification:Notification) -> Void {
        
        if let indexs = self.viewControllers?[3] as? UINavigationController{
            print(indexs)
            if let datas = indexs.topViewController as? MorePageViewController{
                if datas.ScreenshotBool{
                    let ProtectView = UIView()
                    ProtectView.backgroundColor = .black
                    self.view.addSubview(ProtectView)
                    ProtectView.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                    
                    let AC = UIAlertController(title: "Warning", message: "You Turn On Prevent ScreenShot Function", preferredStyle: .alert)
                    let OK = UIAlertAction(title: "OK", style: .default) { Action in
                        ProtectView.removeFromSuperview()
                    }
                    AC.addAction(OK)
                    present(AC , animated: true)
                }
            }
        }
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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        for i in 0..<tabBar.items!.count{
            if item == tabBar.items![i]{
                addTabbarIndicatorView(index: i)
                break
            }
        }
    }
}

