//
//  LoginPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var Image :UIImageView!
    
    var PasswordTextField : UnitTextField!
    var ForgatButton , RightButton : UIButton!
    func UIInit(){
        PasswordTextField = UnitTextField()
        RightButton = UIButton()
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
        
        PasswordTextField.backgroundColor = .white
        PasswordTextField.layer.cornerRadius = 20
        
        PasswordTextField.placeholder = "Please Input Your Password"
        
        PasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        PasswordTextField.leftViewMode = .always
        
        RightButton.isSelected = true
        RightButton.setImage(UIImage(systemName:"eye.fill"), for: .selected)
        RightButton.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
        RightButton.addTarget(self, action: #selector(self.RightViewButton(sender:)), for: .touchDown)
        PasswordTextField.rightView = RightButton
        PasswordTextField.rightViewMode = .always
        PasswordTextField.isSecureTextEntry = true
        
        
        ForgatButton.backgroundColor = .clear
        ForgatButton.setTitle("Forgat Password >", for: .normal)
        ForgatButton.setTitleColor(.orange, for: .normal)
        ForgatButton.addTarget(self, action: #selector(ForgatAction(sender:)), for: .touchDown)
    }
    
    @objc func ForgatAction(sender: UIButton){
        //GO TO ForgatPage
    }
    
    @objc func RightViewButton(sender:UIButton){
        if sender.isSelected{
            PasswordTextField.isSecureTextEntry = false
            RightButton.isSelected = false
        }else if sender.isSelected == false{
            PasswordTextField.isSecureTextEntry = true
            RightButton.isSelected = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
    }
    
    
    
    
}
