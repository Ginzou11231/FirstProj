//
//  Page3ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

class UnitSwitch : UISwitch{
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
}

protocol GeneratorPageDelegate{
    func SetLength(Length int : Int)
}

class GeneratorPageViewController: UIViewController , UITextFieldDelegate , GeneratorPageDelegate {
    
    var PasswordTF : UITextField!
    var GenerateBtn , CopyBtn , TFRightBtn : UIButton!
    var LengthTF : UnitTextField!
    var SettingLabel , UpperLabel , LowerLabel , NumLabel , SpecLabel : UILabel!
    var UpperSwitch , LowerSwitch , NumSwitch , SpecSwitch : UnitSwitch!
    var PasswordLength : Int = 0
    
    
    func UIInit(){
        navigationItem.title = "GENARATOR"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ,NSAttributedString.Key.foregroundColor : UIColor.white]
        
        PasswordTF = UITextField()
        PasswordTF.placeholder = "Generate Result"
        PasswordTF.isEnabled = false
        PasswordTF.textAlignment = .center
        PasswordTF.backgroundColor = .white
        PasswordTF.layer.cornerRadius = 20
        PasswordTF.font = .boldSystemFont(ofSize: 20)
        self.view.addSubview(PasswordTF)
        PasswordTF.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        GenerateBtn = UIButton()
        GenerateBtn.layer.cornerRadius = 20
        GenerateBtn.setTitle("GENERATE PASSWORD", for: .normal)
        GenerateBtn.setTitleColor(.black, for: .normal)
        GenerateBtn.setTitleColor(.lightGray, for: .highlighted)
        GenerateBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        GenerateBtn.backgroundColor = .systemYellow
        
        GenerateBtn.addTarget(self, action: #selector(GenerateBtnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(GenerateBtn)
        GenerateBtn.snp.makeConstraints { make in
            make.top.equalTo(PasswordTF.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        CopyBtn = UIButton()
        CopyBtn.layer.cornerRadius = 20
        CopyBtn.setTitle("COPY PASSWORD", for: .normal)
        CopyBtn.setTitleColor(.black, for: .normal)
        CopyBtn.setTitleColor(.lightGray, for: .highlighted)
        CopyBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        CopyBtn.backgroundColor = .systemYellow
        
        CopyBtn.addTarget(self, action: #selector(CopyBtnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(CopyBtn)
        CopyBtn.snp.makeConstraints { make in
            make.top.equalTo(GenerateBtn.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        SettingLabel = UILabel()
        SettingLabel.text = "Generate Setting"
        SettingLabel.font = .boldSystemFont(ofSize: 14)
        SettingLabel.textColor = .lightGray
        SettingLabel.textAlignment = .center
        self.view.addSubview(SettingLabel)
        SettingLabel.snp.makeConstraints { make in
            make.top.equalTo(CopyBtn.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(20)
        }
        
        LengthTF = UnitTextField()
        LengthTF.placeholder = "Password Length"
        LengthTF.layer.cornerRadius = 20
        LengthTF.backgroundColor = .white
        LengthTF.delegate = self
        
        TFRightBtn = UIButton()
        TFRightBtn.isEnabled = false
        TFRightBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        TFRightBtn.tintColor = .black

        LengthTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        LengthTF.leftViewMode = .always
        LengthTF.rightView = TFRightBtn
        LengthTF.rightViewMode = .always
        
        self.view.addSubview(LengthTF)
        LengthTF.snp.makeConstraints { make in
            make.top.equalTo(SettingLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        UpperLabel = UILabel()
        LowerLabel = UILabel()
        NumLabel = UILabel()
        SpecLabel = UILabel()
        
        UpperSwitch = UnitSwitch()
        LowerSwitch = UnitSwitch()
        NumSwitch = UnitSwitch()
        SpecSwitch = UnitSwitch()
        
        SetLabelSwitch(Label: UpperLabel, Text: "A - Z", Switch: UpperSwitch, SnapTarget: LengthTF)
        SetLabelSwitch(Label: LowerLabel, Text: "a - z", Switch: LowerSwitch, SnapTarget: UpperLabel)
        SetLabelSwitch(Label: NumLabel, Text: "12345", Switch: NumSwitch, SnapTarget: LowerLabel)
        SetLabelSwitch(Label: SpecLabel, Text: "!@#$%", Switch: SpecSwitch, SnapTarget: NumLabel)
    }
    
    func SetLabelSwitch(Label LB : UILabel , Text str : String , Switch SW : UISwitch , SnapTarget view : UIView){
        
        LB.text = str
        LB.textAlignment = .left
        LB.textColor = .white
        LB.font = .boldSystemFont(ofSize: 20)
        self.view.addSubview(LB)
        LB.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(45)
            make.left.equalToSuperview().offset(45)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        SW.onTintColor = .systemYellow
        SW.isOn = true
        self.view.addSubview(SW)
        SW.snp.makeConstraints { make in
            make.centerY.equalTo(LB)
            make.right.equalToSuperview().offset(-45)
            make.width.equalTo(50)
        }
    }
    
    func SetLength(Length int : Int){
            PasswordLength = int
            LengthTF.text = "Password Length: " + String(PasswordLength)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == LengthTF{
            let PickVC = GeneratorPickVC()
            PickVC.GeneratorDelegate = self
            
            if let sheetPresentationController = PickVC.sheetPresentationController {
                sheetPresentationController.detents = [.medium()]
            }
            
            present(PickVC ,animated: true)
            self.view.endEditing(true)
        }
    }
    
    @objc func GenerateBtnAction(sender : UIButton){
        if let check = LengthTF.text?.isEmpty , check {return}
        
        if PasswordLength == 0 {return}
        
        var str = ""
        var CurrentLength : Int = 0
        
        while CurrentLength < PasswordLength{
            let random = Int.random(in: 33...126)
            
            if UpperSwitch.isOn == false{
                if random >= 65 && random <= 90{
                    continue
                }
            }
            
            if LowerSwitch.isOn == false{
                if random >= 97 && random <= 122{
                    continue
                }
            }
            
            if NumSwitch.isOn == false{
                if random >= 48 && random <= 57{
                    continue
                }
            }
            
            if SpecSwitch.isOn == false{
                if (random >= 33 && random <= 47) || (random >= 58 && random <= 64) || (random >= 91 && random <= 96) || (random >= 123 && random <= 126) {
                    continue
                }
            }
            
            let char = Character(UnicodeScalar(random)!)
            
            str.append(char)
            CurrentLength += 1
        }
        PasswordTF.text = str
        
    }
    
    @objc func CopyBtnAction(sender : UIButton){
        let AC = UIAlertController(title: "", message: "Password Copied", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default) { Action in
            UIPasteboard.general.string = self.PasswordTF.text
        }
        
        AC.addAction(OK)
        present(AC ,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LengthTF.text = ""
        PasswordTF.text = ""
    }


}
