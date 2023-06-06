//
//  ForgatPassword.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit
import SnapKit

class ForgatPageViewController: UIViewController {
    
    @IBOutlet weak var Label : UILabel!
    
    var LoginDelegate : LoginPageDelegate!
    
    var HintTF : UITextField!
    var PasswordTF : UnitTextField!
    var BackBtn , TFRightBtn : UIButton!
    
    func UIInit(){
        BackBtn = UIButton()
        BackBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        BackBtn.addTarget(self, action: #selector(BackBtnAction), for: .touchUpInside)
        BackBtn.tintColor = .white
        self.view.addSubview(BackBtn)
        BackBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalTo(50)
        }
        
        HintTF = UITextField()
        PasswordTF = UnitTextField()
        
        self.view.addSubview(HintTF)
        self.view.addSubview(PasswordTF)
        
        HintTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Label.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        PasswordTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(HintTF.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        SetTextField(TextUI: HintTF, InputHint: UserDefaults.standard.object(forKey: "Hint") as! String)
        SetTextField(TextUI: PasswordTF, InputHint: "Please Input Your Password")
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
    }
    
    func SetTextField(TextUI TF : UITextField , InputHint Hint : String){
        TF.backgroundColor = .white
        TF.layer.cornerRadius = 20
        
        if TF == HintTF{
            TF.text = Hint
            TF.textAlignment = .center
            TF.isEnabled = false
        }else{
            TF.placeholder = Hint
        }
        
        TF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        TF.leftViewMode = .always
        
        if TF == PasswordTF{
            TFRightBtn = UIButton()
            TFRightBtn.isSelected = true
            TFRightBtn.tintColor = .darkGray
            TFRightBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            TFRightBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            TFRightBtn.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
            TF.rightView = TFRightBtn
            TF.rightViewMode = .always
            TF.isSecureTextEntry = true
        }
    }
    
    @objc func RightBtnAction(sender:UIButton){
        if sender.isSelected{
            PasswordTF.isSecureTextEntry = false
            TFRightBtn.isSelected = false
        }else if sender.isSelected == false{
            PasswordTF.isSecureTextEntry = true
            TFRightBtn.isSelected = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    
    @IBAction func DoneButton(_ sender : UIButton){
        
        if TextFieldCheck(TextField: PasswordTF, EmptyMessage: "Password is Empty", FieldName: "Password"){
            return
        }
        
        if let check = UserDefaults.standard.object(forKey: "Password") as? String{
            if check == PasswordTF.text{
                let AC = UIAlertController(title: "", message: "Password is Confirm\nBack To Previous Page", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { Action in
                    self.LoginDelegate.SetLoginPassword(Password: self.PasswordTF.text!)
                    self.dismiss(animated: true)
                }
                AC.addAction(OK)
                present(AC , animated: true)
            }else{
                let AC = UIAlertController(title: "", message: "Password is Wrong", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default)
                AC.addAction(OK)
                present(AC , animated: true)
            }
        }
    }
    
    func TextFieldCheck(TextField TF : UITextField , EmptyMessage msg : String , FieldName Name : String) -> Bool{
        if let check = TF.text?.isEmpty , check{
            let AC = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default,handler: nil)
            AC.addAction(OK)
            present(AC, animated: true)
            return true
        }
        return false
    }
}
