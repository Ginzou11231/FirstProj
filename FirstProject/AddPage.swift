//
//  AddPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/19.
//

import UIKit
import SnapKit

class AddViewController: UIViewController , UITextViewDelegate , UITextFieldDelegate {
    
    var HomeDelegate : HomePageDelegate?
    var TitleLabel : UILabel!
    var BackGroundView : UIView!
    var BackBtn , AddBtn , ImageBtn , RightBtn : UIButton!
    var NameTF , CategoryTF , AccountTF , PasswordTF , UrlTF  : UnitTextField!
    var CommentTV : UITextView!
    
    func UIInit(){
        BackBtn = UIButton()
        BackBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        BackBtn.addTarget(self, action: #selector(BackBtnAction), for: .touchUpInside)
        BackBtn.tintColor = .white
        self.view.addSubview(BackBtn)
        BackBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalTo(50)
        }
        
        TitleLabel = UILabel()
        TitleLabel.text = "ADD"
        TitleLabel.font = UIFont.systemFont(ofSize: 24)
        TitleLabel.textColor = .white
        TitleLabel.textAlignment = .center
        self.view.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(BackBtn.snp.top)
            make.height.equalTo(BackBtn.snp.height)
        }
        
        BackGroundView = UIView()
        BackGroundView.backgroundColor = UIColor(cgColor: CGColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1))
        BackGroundView.layer.cornerRadius = 20
        self.view.addSubview(BackGroundView)
        BackGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 100, left: 20, bottom: 30, right: 20))
        }
        
        ImageBtn = UIButton()
        ImageBtn.setImage(UIImage(named: "Searchimage"), for: .normal)
        ImageBtn.layer.cornerRadius = 50
        ImageBtn.addTarget(self, action: #selector(ImageBtnAction(sender:)), for: .touchUpInside)
        BackGroundView.addSubview(ImageBtn)
        ImageBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        NameTF = UnitTextField()
        CategoryTF = UnitTextField()
        AccountTF = UnitTextField()
        PasswordTF = UnitTextField()
        UrlTF = UnitTextField()
        
        SetTextField(TextField: NameTF, String: "Name" , SnapTarget: ImageBtn)
        SetTextField(TextField: CategoryTF, String: "Category" , SnapTarget: NameTF)
        SetTextField(TextField: AccountTF, String: "Account" , SnapTarget: CategoryTF)
        SetTextField(TextField: PasswordTF, String: "Password" , SnapTarget: AccountTF)
        SetTextField(TextField: UrlTF, String: "URL" , SnapTarget: PasswordTF)
        
        CommentTV = UITextView()
        CommentTV.delegate = self
        CommentTV.backgroundColor = .white
        CommentTV.layer.cornerRadius = 20
        CommentTV.font = UIFont.systemFont(ofSize: 18)
        CommentTV.textContainer.lineFragmentPadding = 12
        CommentTV.textAlignment = .left
        CommentTV.text = "Comment"
        CommentTV.textColor = .lightGray
        CommentTV.isEditable = true
        CommentTV.isSelectable = true
        BackGroundView.addSubview(CommentTV)
        
        CommentTV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(180)
            make.top.equalTo(UrlTF.snp.bottom).offset(20)
        }
        
        AddBtn = UIButton()
        AddBtn.layer.cornerRadius = 20
        AddBtn.setTitle("A D D", for: .normal)
        AddBtn.setTitleColor(.black, for: .normal)
        AddBtn.setTitleColor(.lightGray, for: .highlighted)
        AddBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        AddBtn.backgroundColor = .systemYellow
        
        AddBtn.addTarget(self, action: #selector(AddBtnAction(sender:)), for: .touchUpInside)
        BackGroundView.addSubview(AddBtn)
        AddBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(CommentTV.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
    }
    
    func SetTextField(TextField TF : UITextField , String str : String , SnapTarget view : UIView){
        TF.delegate = self
        TF.backgroundColor = .white
        TF.layer.cornerRadius = 20
        TF.placeholder = str
        TF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        TF.leftViewMode = .always
        
        if TF == PasswordTF{
            RightBtn = UIButton()
            RightBtn.isSelected = true
            RightBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
            RightBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
            RightBtn.addTarget(self, action: #selector(self.RightBtnAciton(sender:)), for: .touchUpInside)
            TF.rightView = RightBtn
            TF.rightViewMode = .always
            TF.isSecureTextEntry = true
        }
        
        BackGroundView.addSubview(TF)
        TF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
    }
    
    @objc func ImageBtnAction(sender:UIButton){
        print("Search Icon Image in LocalDevice")
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
    }
    
    @objc func RightBtnAciton(sender:UIButton){
        if sender.isSelected{
            PasswordTF.isSecureTextEntry = false
            RightBtn.isSelected = false
        }else if sender.isSelected == false{
            PasswordTF.isSecureTextEntry = true
            RightBtn.isSelected = true
        }
    }
    
    @objc func AddBtnAction(sender:UIButton){
        if let check = NameTF.text?.isEmpty , check{
            let AlertController = UIAlertController(title: "Error", message: "Name is Empty", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title:"OK" , style: .default , handler: nil)
            AlertController.addAction(AlertAction)
            present(AlertController, animated: true,completion: nil)
            return
        }
        if let check = CategoryTF.text?.isEmpty , check{
            let AlertController = UIAlertController(title: "Error", message: "Category is Empty", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title:"OK" , style: .default , handler: nil)
            AlertController.addAction(AlertAction)
            present(AlertController, animated: true,completion: nil)
            return
        }
        if let check = AccountTF.text?.isEmpty , check{
            let AlertController = UIAlertController(title: "Error", message: "Account is Empty", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title:"OK" , style: .default , handler: nil)
            AlertController.addAction(AlertAction)
            present(AlertController, animated: true,completion: nil)
            return
        }
        if let check = PasswordTF.text?.isEmpty , check{
            let AlertController = UIAlertController(title: "Error", message: "Password is Empty", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title:"OK" , style: .default , handler: nil)
            AlertController.addAction(AlertAction)
            present(AlertController, animated: true,completion: nil)
            return
        }
    
        let AlertController = UIAlertController(title: "Alert", message: "There Are Currently No Folder", preferredStyle: .alert)
        let AlertAction = UIAlertAction(title: "OK", style: .default) { UIAlert in
            let Model = AddPageModel()
            Model.Image = self.ImageBtn.currentImage
            Model.Name = self.NameTF.text
            Model.Category = self.CategoryTF.text
            Model.Account = self.AccountTF.text
            Model.Password = self.PasswordTF.text
            
            if let check = self.UrlTF.text?.isEmpty , check{
                Model.Url = "None"
            }else{
                Model.Url = self.UrlTF.text
            }
            if self.CommentTV.text == "Comment"{
                Model.Comment = "None"
            }else{
                Model.Comment = self.CommentTV.text
            }
            
            self.HomeDelegate?.AddCell(AddPageModel: Model)
            let AlertController = UIAlertController(title: "", message: "Item Created Successfully", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                self.dismiss(animated: true)
            }
            AlertController.addAction(AlertAction)
            self.present(AlertController , animated: true)
        }
        AlertController.addAction(AlertAction)
        present(AlertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Comment" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "Comment"
            textView.textColor = .lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    
}
