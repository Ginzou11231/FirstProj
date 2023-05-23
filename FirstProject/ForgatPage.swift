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
    
    var HintTextField , PasswordTextField : UnitTextField!
    var RightButton : UIButton!
    
    func UIInit(){
        HintTextField = UnitTextField()
        PasswordTextField = UnitTextField()
        
        self.view.addSubview(HintTextField)
        self.view.addSubview(PasswordTextField)
        
        HintTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Label.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        PasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(HintTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        LeftRightViewInit(TextUI: HintTextField, InputHint: "aaa")
        LeftRightViewInit(TextUI: PasswordTextField, InputHint: "Please Input Your Password")
    }
    
    func LeftRightViewInit(TextUI text : UITextField , InputHint Hint : String){
        text.backgroundColor = .white
        text.layer.cornerRadius = 20
        
        if text == HintTextField{
            text.text = Hint
        }else{
            text.placeholder = Hint
        }
        
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        text.leftViewMode = .always
        
        if text == PasswordTextField{
            RightButton = UIButton()
            RightButton.isSelected = true
            RightButton.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            RightButton.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            RightButton.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchDown)
            text.rightView = RightButton
            text.rightViewMode = .always
            text.isSecureTextEntry = true
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    
    @IBAction func DoneButton(_ sender : UIButton){
        
        if PasswordTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "Error", message: "SetPassword is Empty", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
            alertController.addAction(alertaction)
            present(alertController, animated: true,completion: nil)
            return
        }
        
        let alertController = UIAlertController(title: "clear", message: "check done but no working", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
        alertController.addAction(alertaction)
        present(alertController, animated: true,completion: nil)
        
    }
    
}
