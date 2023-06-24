//
//  Page4ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit
import SafariServices

protocol MorePageDelegate{
    func ResetPassword()
}

class MorePageViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , MorePageDelegate , SFSafariViewControllerDelegate {
    
    
    var TableViewTitles : [String] = ["Change Password" , "Generate Password" , "Prevent Screenshot" , "Share App" , "Contact Us"]
    var TableView : UITableView!
    var ScreenshotBool : Bool!
    var animeBool = true
    
    func UIInit(){
        navigationItem.title = "MORE"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ,NSAttributedString.Key.foregroundColor : UIColor.white]
        
        TableView = UITableView()
        TableView.backgroundColor = .clear
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(MoreTableCell.self, forCellReuseIdentifier: "MoreTableCell")
        self.view.addSubview(TableView)
        TableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func ResetPassword(){
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
        if ScreenshotBool == nil{
            ScreenshotBool = true
            TableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableCell") as! MoreTableCell
        
        cell.TitleLabel.text = TableViewTitles[indexPath.row]
        
        switch indexPath.row{
        case 0 , 1 , 3 , 4 :
            cell.Switch.isHidden = true
        default:
            cell.Switch.isOn = ScreenshotBool
            cell.ImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0 :
            if let vc = storyboard?.instantiateViewController(identifier: "LoginPage") as? LoginPageViewController{
                vc.modalPresentationStyle = .fullScreen
                vc.PrevPageInt = PrevPageEnum.More.rawValue
                vc.MoreDelegate = self
                present(vc , animated: true)
            }
        case 1 :
            if let TBC = tabBarController as? TabbarController{
                TBC.selectedIndex = 2
                TBC.tabBar(TBC.tabBar, didSelect: TBC.tabBar.items![2])
            }
        case 3 :
            print("a")
            let ShareUrl = URL(string: "https://www.gamer.com.tw/")!
            let ShareSheetVC = UIActivityViewController(activityItems: [ShareUrl], applicationActivities: nil)
            present(ShareSheetVC , animated: true)
        case 4 :
            let SafariVC = SFSafariViewController(url: URL(string: "https://www.google.com.tw/")!)
            SafariVC.preferredBarTintColor = .black
            SafariVC.preferredControlTintColor = .white
            SafariVC.dismissButtonStyle = .close
            SafariVC.delegate = self
            present(SafariVC , animated: true)
            
        default:
            if ScreenshotBool{
                ScreenshotBool = false
            }else{
                ScreenshotBool = true
            }
            UserDefaults.standard.set(ScreenshotBool, forKey: "Screenshot")
        }
        TableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if animeBool{
            cell.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: cell.contentView.bounds.height)
            
            UIView.animate(withDuration: 0.3,delay: 0.05 * Double(indexPath.row), animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.bounds.height)
            }) { done in
                self.animeBool = false
            }
        }
    }
}
