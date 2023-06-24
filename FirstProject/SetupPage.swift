//
//  ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit
import SnapKit

final class UnitTextField : UITextField{
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 40, y: 0, width: 30 , height: bounds.height)
    }
}

class SetupPageViewController: UIViewController {
    
    @IBOutlet weak var Label : UILabel!

    var resetBool : Bool!
    var MoreDelegate : MorePageDelegate!
    var PasswordTF , ConfirmTF, HintTF : UnitTextField!
    var PasswordTFBtn , ConfirmTFBtn , BackBtn : UIButton!
    
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
        
        if resetBool{
            BackBtn.isHidden = false
        }else{
            BackBtn.isHidden = true
        }
        
        PasswordTF = UnitTextField()
        ConfirmTF = UnitTextField()
        HintTF = UnitTextField()
        
        self.view.addSubview(PasswordTF)
        self.view.addSubview(ConfirmTF)
        self.view.addSubview(HintTF)
        
        PasswordTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Label.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ConfirmTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(PasswordTF.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        HintTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(ConfirmTF.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        SetTextField(TextUI: PasswordTF, InputHint: "Enter Security Password")
        SetTextField(TextUI: ConfirmTF, InputHint: "Confirm Security Password")
        SetTextField(TextUI: HintTF, InputHint: "Password Hint")
    }
    
    func SetTextField(TextUI TF : UITextField , InputHint Hint : String){
        TF.backgroundColor = .white
        TF.layer.cornerRadius = 20
        TF.placeholder = Hint
        
        TF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        TF.leftViewMode = .always
        
        if TF == PasswordTF{
            PasswordTFBtn = UIButton()
            PasswordTFBtn.isSelected = true
            PasswordTFBtn.tintColor = .darkGray
            PasswordTFBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            PasswordTFBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            PasswordTFBtn.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
            TF.rightView = PasswordTFBtn
            TF.rightViewMode = .always
            TF.isSecureTextEntry = true
        }else if TF == ConfirmTF{
            ConfirmTFBtn = UIButton()
            ConfirmTFBtn.isSelected = true
            ConfirmTFBtn.tintColor = .darkGray
            ConfirmTFBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            ConfirmTFBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            ConfirmTFBtn.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
            TF.rightView = ConfirmTFBtn
            TF.rightViewMode = .always
            TF.isSecureTextEntry = true
        }
    }
    
    @objc func RightBtnAction(sender:UIButton){
        if sender == PasswordTFBtn{
            if sender.isSelected{
                PasswordTF.isSecureTextEntry = false
                PasswordTFBtn.isSelected = false
            }else if sender.isSelected == false{
                PasswordTF.isSecureTextEntry = true
                PasswordTFBtn.isSelected = true
            }
        }else if sender == ConfirmTFBtn{
            if sender.isSelected{
                ConfirmTF.isSecureTextEntry = false
                ConfirmTFBtn.isSelected = false
            }else if sender.isSelected == false{
                ConfirmTF.isSecureTextEntry = true
                ConfirmTFBtn.isSelected = true
            }
        }
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UIInit()
    }
    
    
    @IBAction func DoneButton(_ sender : UIButton){
        
        self.view.endEditing(true)
        
        if TextFieldCheck(TextField: PasswordTF , EmptyMessage: "Password is Empty" , FieldName: "Password"){
            return
        }
        if TextFieldCheck(TextField: ConfirmTF, EmptyMessage: "Confirm is Empty" , FieldName: "Confirm"){
            return
        }
        if TextFieldCheck(TextField: HintTF, EmptyMessage: "Hint is Empty" , FieldName: "Hint"){
            return
        }
        
        let AC = UIAlertController(title: "Done", message: "Password Setting is Complete", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default) { Action in
            UserDefaults.standard.set(self.PasswordTF.text, forKey: "Password")
            UserDefaults.standard.set(self.HintTF.text, forKey: "Hint")
            
            if let check = self.MoreDelegate{
                check.ResetPassword()
            }else{
                self.dismiss(animated: true)
            }
        }
        AC.addAction(OK)
        present(AC, animated: true)
    }
    
    func TextFieldCheck(TextField TF : UITextField , EmptyMessage msg : String , FieldName Name : String) -> Bool{
        
        if let check = TF.text?.isEmpty , check{
            let AC = UIAlertController(title: "", message: msg, preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default,handler: nil)
            AC.addAction(OK)
            present(AC, animated: true)
            return true
        }else if isBlank(String: TF.text!){
            if TF != HintTF{
                let AC = UIAlertController(title: "", message: Name + " Can't Using Space Word", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default)
                AC.addAction(OK)
                present(AC, animated: true)
                return true
            }
        }else if TF == ConfirmTF{
            if ConfirmTF.text != PasswordTF.text{
                let AC = UIAlertController(title: "", message: "Password and Confirm is Different", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default)
                AC.addAction(OK)
                present(AC, animated: true)
                return true
            }
        }
        return false
    }
    
    func isBlank(String str : String) -> Bool{
        for char in str{
            if char.isWhitespace{
                return true
            }
        }
        return false
    }
}
