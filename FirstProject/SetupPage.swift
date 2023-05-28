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
    
    var SetTextField , ConfirmTexfield, HintTextField : UnitTextField!
    var SetButton , ConfirmButton : UIButton!
    
    func UIInit(){
        SetTextField = UnitTextField()
        ConfirmTexfield = UnitTextField()
        HintTextField = UnitTextField()
        
        self.view.addSubview(SetTextField)
        self.view.addSubview(ConfirmTexfield)
        self.view.addSubview(HintTextField)
        
        SetTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(Label.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        ConfirmTexfield.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(SetTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        HintTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(ConfirmTexfield.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        LeftRightViewInit(TextUI: SetTextField, InputHint: "Enter Security Password")
        LeftRightViewInit(TextUI: ConfirmTexfield, InputHint: "Confirm Security Password")
        LeftRightViewInit(TextUI: HintTextField, InputHint: "Password Hint")
    }
    
    func LeftRightViewInit(TextUI text : UITextField , InputHint Hint : String){
        text.backgroundColor = .white
        text.layer.cornerRadius = 20
        text.placeholder = Hint
        
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        text.leftViewMode = .always
        
        if text == SetTextField{
            SetButton = UIButton()
            SetButton.isSelected = true
            SetButton.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            SetButton.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            SetButton.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
            text.rightView = SetButton
            text.rightViewMode = .always
            text.isSecureTextEntry = true
        }else if text == ConfirmTexfield{
            ConfirmButton = UIButton()
            ConfirmButton.isSelected = true
            ConfirmButton.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            ConfirmButton.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            ConfirmButton.addTarget(self, action: #selector(self.RightBtnAction(sender:)), for: .touchUpInside)
            text.rightView = ConfirmButton
            text.rightViewMode = .always
            text.isSecureTextEntry = true
        }
    }
    
    @objc func RightBtnAction(sender:UIButton){
        if sender == SetButton{
            if sender.isSelected{
                SetTextField.isSecureTextEntry = false
                SetButton.isSelected = false
            }else if sender.isSelected == false{
                SetTextField.isSecureTextEntry = true
                SetButton.isSelected = true
            }
        }else if sender == ConfirmButton{
            if sender.isSelected{
                ConfirmTexfield.isSecureTextEntry = false
                ConfirmButton.isSelected = false
            }else if sender.isSelected == false{
                ConfirmTexfield.isSecureTextEntry = true
                ConfirmButton.isSelected = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIInit()
    }
    
    @IBAction func DoneButton(_ sender : UIButton){
        
        if let aaa = SetTextField.text?.isEmpty , aaa{
            let alertController = UIAlertController(title: "Error", message: "SetPassword is Empty", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
            alertController.addAction(alertaction)
            present(alertController, animated: true,completion: nil)
            return
        }else if ConfirmTexfield.text?.isEmpty == true{
            let alertController = UIAlertController(title: "Error", message: "ConfirmPassword is Empty", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
            alertController.addAction(alertaction)
            present(alertController, animated: true,completion: nil)
            return
        }else if HintTextField.text?.isEmpty == true{
            let alertController = UIAlertController(title: "Error", message: "PasswordHint is Empty", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
            alertController.addAction(alertaction)
            present(alertController, animated: true,completion: nil)
            return
        }
        
        if SetTextField.text != ConfirmTexfield.text{
            let alertController = UIAlertController(title: "Error", message: "Password and Confirm is different", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default,handler: nil)
            alertController.addAction(alertaction)
            present(alertController, animated: true,completion: nil)
            return
        }

        let alertController = UIAlertController(title: "Done", message: "Password Setting is Complete", preferredStyle: .alert)
        let alertaction = UIAlertAction(title: "OK", style: .default,
                                        handler: {action in
            /* save model in phone */
            
            self.dismiss(animated: true)
        })
        alertController.addAction(alertaction)
        present(alertController, animated: true,completion: nil)
    }
    
}
