//
//  LoginPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit
import SnapKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var Image :UIImageView!
    
    var PasswordTextField : UnitTextField!
    var ForgatButton , RightButton : UIButton!
    
    func UIInit(){
        PasswordTextField = UnitTextField()
        ForgatButton = UIButton()
        
        self.view.addSubview(PasswordTextField)
        self.view.addSubview(ForgatButton)
        
        PasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Image.snp.bottom).offset(160)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ForgatButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(PasswordTextField.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ForgatButton.backgroundColor = .clear
        ForgatButton.setTitle("Forgat Password >", for: .normal)
        ForgatButton.setTitleColor(.orange, for: .normal)
        ForgatButton.addTarget(self, action: #selector(GoToForgatPage(sender:)), for: .touchUpInside)
        
        PasswordTextField.backgroundColor = .white
        PasswordTextField.layer.cornerRadius = 20
        PasswordTextField.placeholder = "Please Input Your Password"
        
        PasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        PasswordTextField.leftViewMode = .always
        
        RightButton = UIButton()
        RightButton.isSelected = true
        RightButton.setImage(UIImage(systemName:"eye.fill"), for: .selected)
        RightButton.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
        RightButton.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
        PasswordTextField.rightView = RightButton
        PasswordTextField.rightViewMode = .always
        PasswordTextField.isSecureTextEntry = true
    }
    
    @objc func RightBtnAction(sender:UIButton){
        if sender.isSelected{
            PasswordTextField.isSecureTextEntry = false
            RightButton.isSelected = false
        }else if sender.isSelected == false{
            PasswordTextField.isSecureTextEntry = true
            RightButton.isSelected = true
        }
    }
    
    @objc func GoToForgatPage(sender : UIButton){
        if let vc = storyboard?.instantiateViewController(identifier: "ForgatPage") as? ForgatPageViewController{
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
//        let alertController = UIAlertController(title: "Setting", message: "Can't Find Password Data", preferredStyle: .alert)
//        let alert1 = UIAlertAction(title: "Go to Setting", style: .default ,
//                                   handler: {action in print("aaa")
//            if let vc = self.storyboard?.instantiateViewController(identifier: "SetupPage") as? SetupPageViewController{
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc , animated: true)
//            }
//        })
//        alertController.addAction(alert1)
//        present(alertController, animated: true)
    }
    
    @IBAction func DoneButton(sender:UIButton){
        if let tabbar = self.storyboard?.instantiateViewController(identifier:"Tabbar") as? TabbarController{
            tabbar.modalPresentationStyle = .fullScreen
            present(tabbar , animated: true)
        }
    }
}
