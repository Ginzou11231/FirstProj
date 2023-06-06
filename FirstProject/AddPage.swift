//
//  AddPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/19.
//

import UIKit
import SnapKit

class AddPageViewController: UIViewController , UITextViewDelegate {
    
    var HomeDelegate : HomePageDelegate?
    var DetailDelegate : DetailPageDelegate?
    
    var EditModel : ListDataModel!
    var isReEdit : Bool = false
    
    var BackgroundImageView : UIImageView!
    var TitleLabel : UILabel!
    var BackgroundView : UIView!
    var BackBtn , AddBtn , ImageBtn , RightBtn : UIButton!
    var NameTF , CategoryTF , AccountTF , PasswordTF , UrlTF  : UnitTextField!
    var CommentTV : UITextView!
    
    func UIInit(){
        BackgroundImageView = UIImageView()
        BackgroundImageView.image = UIImage(named: "BG")
        self.view.addSubview(BackgroundImageView)
        BackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        TitleLabel = UILabel()
        TitleLabel.text = "ADD"
        TitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        TitleLabel.textColor = .white
        TitleLabel.textAlignment = .center
        self.view.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(BackBtn.snp.top)
            make.height.equalTo(BackBtn.snp.height)
        }
        
        BackgroundView = UIView()
        BackgroundView.backgroundColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0.25))
        BackgroundView.layer.cornerRadius = 20
        self.view.addSubview(BackgroundView)
        BackgroundView.snp.makeConstraints { make in
            make.top.equalTo(BackBtn.snp.bottom)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        ImageBtn = UIButton()
        ImageBtn.setBackgroundImage(UIImage(named: "Searchimage"), for: .normal)
        ImageBtn.layer.cornerRadius = 50
        ImageBtn.addTarget(self, action: #selector(ImageBtnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(ImageBtn)
        ImageBtn.snp.makeConstraints { make in
            make.centerX.equalTo(BackgroundView)
            make.top.equalTo(BackgroundView).offset(50)
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
        self.view.addSubview(CommentTV)
        
        CommentTV.snp.makeConstraints { make in
            make.top.equalTo(UrlTF.snp.bottom).offset(20)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(160)
        }
        
        AddBtn = UIButton()
        AddBtn.layer.cornerRadius = 20
        AddBtn.setTitle("A D D", for: .normal)
        AddBtn.setTitleColor(.black, for: .normal)
        AddBtn.setTitleColor(.lightGray, for: .highlighted)
        AddBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        AddBtn.backgroundColor = .systemYellow
        
        AddBtn.addTarget(self, action: #selector(AddBtnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(AddBtn)
        AddBtn.snp.makeConstraints { make in
            make.top.equalTo(CommentTV.snp.bottom).offset(15)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(40)
        }
        
    }
    
    func SetTextField(TextField TF : UITextField , String str : String , SnapTarget view : UIView){
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
            RightBtn.tintColor = .darkGray
            RightBtn.addTarget(self, action: #selector(self.RightBtnAciton(sender:)), for: .touchUpInside)
            TF.rightView = RightBtn
            TF.rightViewMode = .always
            TF.isSecureTextEntry = true
        }
        
        self.view.addSubview(TF)
        TF.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(20)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
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
        self.view.endEditing(true)
        
        if let check = NameTF.text?.isEmpty , check{
            EmptyAlert(Message: "Name is Empty")
            return
        }
        if let check = CategoryTF.text?.isEmpty , check{
            EmptyAlert(Message: "Category is Empty")
            return
        }
        if let check = AccountTF.text?.isEmpty , check{
            EmptyAlert(Message: "Account is Empty")
            return
        }
        if let check = PasswordTF.text?.isEmpty , check{
            EmptyAlert(Message: "Password is Empty")
            return
        }
        
        let NewDataModel = ListDataModel()
        NewDataModel.Name = NameTF.text
        NewDataModel.Category = CategoryTF.text
        NewDataModel.Account = AccountTF.text
        NewDataModel.Password = PasswordTF.text
        //        if let check = self.ImageBtn.currentImage, check != UIImage(named: "Searchimage"){
        NewDataModel.Image = ImageBtn.currentBackgroundImage
        //        }
        if let check = UrlTF.text?.isEmpty , check{
            NewDataModel.Url = "None"
        }else{
            NewDataModel.Url = UrlTF.text
        }
        if let check = CommentTV.text , check == "Comment"{
            NewDataModel.Comment = "None"
        }else{
            NewDataModel.Comment = CommentTV.text
        }
        
        
        if isReEdit{
            if let check = self.HomeDelegate?.CheckCategoryCell(CategoryName: NewDataModel.Category!) , check{
                
                ReEditData(EditModel: EditModel, NewDataModel: NewDataModel , AddFolder: true)
                
            }else{
                if let check = self.HomeDelegate?.CheckFolderSameData(ListData: NewDataModel) , check{
                    OverrideData(EditModel: EditModel, NewDataModel: NewDataModel)
                }else{
                    ReEditData(EditModel: EditModel, NewDataModel: NewDataModel , AddFolder: false)
                }
            }
        }else{
            if let check = self.HomeDelegate?.CheckCategoryCell(CategoryName: NewDataModel.Category!) , check{
                AddData(NewDataModel: NewDataModel, AddFolder: true)
            }else{
                if let check = self.HomeDelegate?.CheckFolderSameData(ListData: NewDataModel) , check{
                    UpdateData(NewDataModel: NewDataModel)
                }else{
                    AddData(NewDataModel: NewDataModel , AddFolder: false)
                }
            }
        }
    }
    
    func EmptyAlert(Message msg : String){
        let AlertController = UIAlertController(title: "", message : msg, preferredStyle: .alert)
        let AlertAction = UIAlertAction(title:"OK" , style: .default , handler: nil)
        AlertController.addAction(AlertAction)
        present(AlertController, animated: true,completion: nil)
    }
    
    func UpdateData(NewDataModel Model : ListDataModel){
        let AC = UIAlertController(title: "Alert", message: "This Name have in Folder\nDo You Want Overwrite Data?", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default) { Action in
            
            let AC = UIAlertController(title: "Warning", message: "If You Want Overwrite Data\nWill Lost Original Data\nAre You Sure Overwrite Data ?", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                
                let AC = UIAlertController(title: "", message: "Data Update Complete", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    
                    self.HomeDelegate?.UpdateListCell(NewData: Model)
                    self.dismiss(animated: true)
                }
                AC.addAction(OK)
                self.present(AC , animated: true)
            }
            let Cancel = UIAlertAction(title: "Cancel", style: .default)
            AC.addAction(OK)
            AC.addAction(Cancel)
            self.present(AC , animated: true)
        }
        
        let Cancel = UIAlertAction(title: "Cancel", style: .default)
        AC.addAction(OK)
        AC.addAction(Cancel)
        present(AC , animated: true)
    }
    
    func AddData(NewDataModel Model : ListDataModel , AddFolder Folder : Bool){
        if Folder{
            let AC = UIAlertController(title: "", message: "There Are Currently No Folder", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                
                self.HomeDelegate?.AddCategoryCell(CategoryName: Model.Category!)
                let AC = UIAlertController(title: "", message: "Data Create Complete", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { Action in
                    self.HomeDelegate?.AddListCell(AddPageModel: Model)
                    self.dismiss(animated: true)
                }
                AC.addAction(OK)
                self.present(AC , animated: true)
            }
            AC.addAction(OK)
            self.present(AC , animated: true )
            
        }else{
            let AC = UIAlertController(title: "", message: "Data Create Complete", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                self.HomeDelegate?.AddListCell(AddPageModel: Model)
                self.dismiss(animated: true)
            }
            AC.addAction(OK)
            self.present(AC , animated: true)
        }

    }
    
    func ReEditData(EditModel Data : ListDataModel , NewDataModel Model : ListDataModel , AddFolder Folder : Bool){
        if Folder{
            let AC = UIAlertController(title: "", message: "There Are Currently No Folder", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                
                self.HomeDelegate?.AddCategoryCell(CategoryName: Model.Category!)
                let AC = UIAlertController(title: "", message: "Data Update Complete", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { Action in
                    
                    if self.DetailDelegate != nil{
                        self.DetailDelegate?.UpdateData(NewData: Model)
                    }
                    
                    self.HomeDelegate?.ReEditListCell(EditDataModel: Data, NewDataModel: Model)
                    self.dismiss(animated: true)
                }
                AC.addAction(OK)
                self.present(AC , animated: true)
            }
            AC.addAction(OK)
            self.present(AC , animated: true)
            
        }else{
            let AC = UIAlertController(title: "Done", message: "Data Update Complete", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                
                if self.DetailDelegate != nil{
                    self.DetailDelegate?.UpdateData(NewData: Model)
                }
                
                self.HomeDelegate?.ReEditListCell(EditDataModel: Data, NewDataModel: Model)
                self.dismiss(animated: true)
            }
            AC.addAction(OK)
            present(AC , animated: true)
        }

    }
    
    func OverrideData(EditModel Data : ListDataModel , NewDataModel Model : ListDataModel){
        let AC = UIAlertController(title: "Alert", message: "This Name have in Folder\nDo You Want Overwrite Data?", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default) { Action in
            
            let AC = UIAlertController(title: "Warning", message: "If You Want Overwrite Data\nWill Lost Original Data\nAre You Sure Overwrite Data ?", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { Action in
                
                let AC = UIAlertController(title: "", message: "Data Update Complete", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    
                    if self.DetailDelegate != nil{
                        self.DetailDelegate?.UpdateData(NewData: Model)
                    }
                    
                    self.HomeDelegate?.OverrideListCell(EditDataModel: Data, NewDataModel: Model)
                    self.dismiss(animated: true)
                }
                AC.addAction(OK)
                self.present(AC , animated: true)
            }
            let Cancel = UIAlertAction(title: "Cancel", style: .default)
            AC.addAction(OK)
            AC.addAction(Cancel)
            self.present(AC , animated: true)
        }
        
        let Cancel = UIAlertAction(title: "Cancel", style: .default)
        AC.addAction(OK)
        AC.addAction(Cancel)
        present(AC , animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Comment" {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        for char in textView.text{
            if !char.isWhitespace{
                return
            }
        }
        textView.text = "Comment"
        textView.textColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
        if EditModel != nil{
            ImageBtn.setImage(EditModel.Image, for: .normal)
            NameTF.text = EditModel.Name
            CategoryTF.text = EditModel.Category
            AccountTF.text = EditModel.Account
            PasswordTF.text = EditModel.Password
            
            if EditModel.Url == "None"{
                UrlTF.text = ""
            }else{
                UrlTF.text = EditModel.Url
            }
            if EditModel.Comment == "None"{
                CommentTV.text = "Comment"
            }else{
                CommentTV.text = EditModel.Comment
                CommentTV.textColor = .black
            }
            
            AddBtn.setTitle("UPDATE", for: .normal)
            isReEdit = true
        }
    }
}
