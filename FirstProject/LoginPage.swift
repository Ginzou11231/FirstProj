//
//  LoginPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit
import SnapKit

protocol LoginPageDelegate{
    func SetLoginPassword(Password pw : String)
    func ResetPassword()
}

enum PrevPageEnum : Int{
    case Folder = 0
    case More = 1
}

class LoginPageViewController: UIViewController , LoginPageDelegate {
    
    @IBOutlet weak var Image :UIImageView!
    
    var PrevPageInt : Int?
    var MoreDelegate : MorePageDelegate!
    
    var DeleteData : String!
    var FolderDelegate : FolderPageDelegate!
    
    var PasswordTF : UnitTextField!
    var ForgatBtn , TFRightBtn , BackBtn : UIButton!
    
    func UIInit(){
        BackBtn = UIButton()
        BackBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        BackBtn.addTarget(self, action: #selector(BackBtnAction), for: .touchUpInside)
        BackBtn.tintColor = .white
        BackBtn.isHidden = true
        self.view.addSubview(BackBtn)
        BackBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalTo(50)
        }
        
        PasswordTF = UnitTextField()
        ForgatBtn = UIButton()
        
        self.view.addSubview(PasswordTF)
        self.view.addSubview(ForgatBtn)
        
        PasswordTF.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Image.snp.bottom).offset(160)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ForgatBtn.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(PasswordTF.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ForgatBtn.backgroundColor = .clear
        ForgatBtn.setTitle("Forgat Password >", for: .normal)
        ForgatBtn.setTitleColor(.orange, for: .normal)
        ForgatBtn.addTarget(self, action: #selector(ForgatBtnAction(sender:)), for: .touchUpInside)
        
        PasswordTF.backgroundColor = .white
        PasswordTF.layer.cornerRadius = 20
        PasswordTF.placeholder = "Please Input Your Password"
        
        PasswordTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        PasswordTF.leftViewMode = .always
        
        TFRightBtn = UIButton()
        TFRightBtn.isSelected = true
        TFRightBtn.tintColor = .darkGray
        TFRightBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
        TFRightBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
        TFRightBtn.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
        PasswordTF.rightView = TFRightBtn
        PasswordTF.rightViewMode = .always
        PasswordTF.isSecureTextEntry = true
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
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
    
    @objc func ForgatBtnAction(sender : UIButton){
        if let vc = storyboard?.instantiateViewController(identifier: "ForgatPage") as? ForgatPageViewController{
            vc.modalPresentationStyle = .fullScreen
            vc.LoginDelegate = self
            present(vc , animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func SetLoginPassword(Password pw : String){
        PasswordTF.text = pw
    }
    
    func ResetPassword() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
        guard UserDefaults.standard.object(forKey: "Password") != nil else {
            let AC = UIAlertController(title: "Welcome", message: "Please Setup Password Data", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                if let vc = self.storyboard?.instantiateViewController(identifier: "SetupPage") as? SetupPageViewController{
                    vc.modalPresentationStyle = .fullScreen
                    vc.resetBool = false
                    self.present(vc , animated: true)
                }
            }
            AC.addAction(OK)
            present(AC , animated: true)
            return
        }
        
        if PrevPageInt != nil{
            BackBtn.isHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        PasswordTF.text = ""
    }
    
    @IBAction func DoneButton(sender:UIButton){
        
        self.view.endEditing(true)
        
        if let Check = PasswordTF.text?.isEmpty , Check{
            let AC = UIAlertController(title: "", message: "Password is Empty", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default)
            AC.addAction(OK)
            present(AC , animated: true)
            return
        }
        
        if let Check = UserDefaults.standard.object(forKey: "Password") as? String{
            if Check == PasswordTF.text{
                if let Prev = PrevPageInt{
                    
                    switch Prev{
                    case PrevPageEnum.Folder.rawValue:
                        let AC = UIAlertController(title: "", message: "Folder Delete Complete", preferredStyle: .alert)
                        let OK = UIAlertAction(title: "OK", style: .default) { Action in
                            self.FolderDelegate.DeleteListCell(DeleteData: self.DeleteData)
                            self.dismiss(animated: true)
                        }
                        AC.addAction(OK)
                        present(AC , animated: true)
                        
                    case PrevPageEnum.More.rawValue:
                        if let vc = storyboard?.instantiateViewController(withIdentifier: "SetupPage") as? SetupPageViewController{
                            vc.modalPresentationStyle = .fullScreen
                            vc.MoreDelegate = MoreDelegate
                            vc.resetBool = true
                            present(vc , animated: true)
                        }
                        
                    default:
                        return
                    }
                }else{
                    if let tabbar = self.storyboard?.instantiateViewController(identifier:"Tabbar") as? TabbarController{
                        tabbar.modalPresentationStyle = .fullScreen
                        present(tabbar , animated: true)
                    }
                }
            }else{
                let AC = UIAlertController(title: "", message: "Password is Wrong", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default)
                AC.addAction(OK)
                present(AC , animated: true)
            }
        }
    }
}
