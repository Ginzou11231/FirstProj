//
//  HomeListDetail.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/6/1.
//

import UIKit
import SnapKit

protocol DetailPageDelegate{
    func UpdateData(NewData Data : ListDataModel)
}

class DetailTextField : UITextField{
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: 30 , height: bounds.height)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 40, y: 0, width: 30 , height: bounds.height)
    }
}

class HomeListDetailViewController: UIViewController , UITextFieldDelegate , DetailPageDelegate {
    
    var ModelData : ListDataModel!
    var HomeDelegate : HomePageDelegate?
    
    var BackgroundImageView , TitleImageView , IconImageView : UIImageView!
    var BackgroundView : UIView!
    var BackBtn , EditBtn , CategoryBtn , TFLeftBtn , TFRightBtn , UrlBtn : UIButton!
    var AccountLable , PasswordLable , UrlLabel , CommentLabel : UILabel!
    var NameLable , AccountIndexLable , UrlIndexLabel : UILabel!
    var CommentTV : UITextView!
    var PasswordTF : DetailTextField!
    
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
        
        EditBtn = UIButton()
        EditBtn.setImage(UIImage(systemName: "pencil"), for: .normal)
        EditBtn.addTarget(self, action: #selector(EditBtnAction(sender:)), for: .touchUpInside)
        EditBtn.tintColor = .white
        self.view.addSubview(EditBtn)
        EditBtn.snp.makeConstraints { make in
            make.top.equalTo(BackBtn)
            make.right.equalToSuperview()
            make.width.equalTo(65)
            make.height.equalTo(50)
        }
        
        TitleImageView = UIImageView()
        TitleImageView.image = UIImage(named: "Logo_h")
        TitleImageView.contentMode = .center
        self.view.addSubview(TitleImageView)
        TitleImageView.snp.makeConstraints { make in
            make.top.equalTo(BackBtn.snp.top)
            make.left.equalTo(BackBtn.snp.right)
            make.right.equalTo(EditBtn.snp.left)
            make.height.equalTo(50)
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
        
        IconImageView = UIImageView()
        IconImageView.image = ModelData.Image
        IconImageView.layer.cornerRadius = 50
        self.view.addSubview(IconImageView)
        IconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(BackgroundView)
            make.top.equalTo(BackgroundView).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        NameLable = UILabel()
        SetLable(Label: NameLable, TextIndex: ModelData.Name!, FontSize: 20, FontColor: .white, SnapTarget: IconImageView)
        
        CategoryBtn = UIButton()
        CategoryBtn.setTitle(ModelData.Category, for: .normal)
        CategoryBtn.setImage(UIImage(systemName: "folder"), for: .normal)
        CategoryBtn.setTitleColor(.white, for: .normal)
        CategoryBtn.tintColor = .white
        CategoryBtn.backgroundColor = UIColor(red: 51 / 255, green: 60 / 255, blue: 91 / 255, alpha: 1)
        CategoryBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        CategoryBtn.layer.cornerRadius = 15
        CategoryBtn.isEnabled = false
        self.view.addSubview(CategoryBtn)
        CategoryBtn.snp.makeConstraints { make in
            make.top.equalTo(NameLable.snp.bottom).offset(20)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(30)
        }
        
        AccountLable = UILabel()
        SetLable(Label: AccountLable, TextIndex: "Account", FontSize: 14, FontColor: .lightGray, SnapTarget: CategoryBtn)

        AccountIndexLable = UILabel()
        SetLable(Label: AccountIndexLable, TextIndex: ModelData.Account!, FontSize: 16, FontColor: .white, SnapTarget: AccountLable)
        
        PasswordLable = UILabel()
        SetLable(Label: PasswordLable, TextIndex: "Password", FontSize: 14, FontColor: .lightGray, SnapTarget: AccountIndexLable)
        
        PasswordTF = DetailTextField()
        PasswordTF.delegate = self
        PasswordTF.text = ModelData.Password
        PasswordTF.textAlignment = .center
        PasswordTF.font = .boldSystemFont(ofSize: 16)
        PasswordTF.textColor = .black
        PasswordTF.backgroundColor = .white
        PasswordTF.layer.cornerRadius = 20
        
        TFLeftBtn = UIButton(frame: CGRect(x: 10, y: 0, width: 40, height: 40))
        TFLeftBtn.tintColor = .darkGray
        TFLeftBtn.setImage(UIImage(systemName:"eye.fill"), for: .selected)
        TFLeftBtn.setImage(UIImage(systemName:"eye.slash.fill"), for: .normal)
        TFLeftBtn.addTarget(self, action: #selector(TFLeftBtnAction(sender:)), for: .touchUpInside)
        PasswordTF.leftView = TFLeftBtn
        PasswordTF.leftViewMode = .always
        
        TFRightBtn = UIButton()
        TFRightBtn.tintColor = .darkGray
        TFRightBtn.setImage(UIImage(systemName:"doc.on.doc"), for: .normal)
        TFRightBtn.addTarget(self, action: #selector(TFRightBtnAction(sender:)), for: .touchUpInside)
        PasswordTF.rightView = TFRightBtn
        PasswordTF.rightViewMode = .always
        
        self.view.addSubview(PasswordTF)
        PasswordTF.snp.makeConstraints { make in
            make.top.equalTo(PasswordLable.snp.bottom).offset(10)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(40)
        }
        
        UrlLabel = UILabel()
        SetLable(Label: UrlLabel, TextIndex: "URL", FontSize: 14, FontColor: .lightGray, SnapTarget: PasswordTF)
        
        UrlIndexLabel = UILabel()
        SetLable(Label: UrlIndexLabel, TextIndex: ModelData.Url!, FontSize: 16, FontColor: .white, SnapTarget: UrlLabel)
        
        UrlBtn = UIButton()
        UrlBtn.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.forward"), for: .normal)
        UrlBtn.tintColor = .white
        UrlBtn.addTarget(self, action: #selector(UrlBtnAction(sender:)), for: .touchUpInside)
        self.view.addSubview(UrlBtn)
        UrlBtn.snp.makeConstraints { make in
            make.top.equalTo(UrlIndexLabel)
            make.left.equalTo(UrlIndexLabel.snp.right).offset(-40)
            make.right.equalTo(UrlIndexLabel)
            make.bottom.equalTo(UrlIndexLabel)
        }
        
        CommentLabel = UILabel()
        SetLable(Label: CommentLabel, TextIndex: "Comment", FontSize: 14, FontColor: .lightGray, SnapTarget: UrlIndexLabel)
        
        CommentTV = UITextView()
        CommentTV.text = ModelData.Comment
        CommentTV.textColor = .white
        CommentTV.bounces = false
        CommentTV.backgroundColor = .clear
        CommentTV.font = .boldSystemFont(ofSize: 16)
        CommentTV.textAlignment = .center
        CommentTV.isEditable = false
        self.view.addSubview(CommentTV)
        CommentTV.snp.makeConstraints { make in
            make.top.equalTo(CommentLabel.snp.bottom).offset(10)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.bottom.equalTo(BackgroundView.snp.bottom).offset(-15)
        }
    }
    
    func SetLable(Label LB : UILabel , TextIndex Str : String , FontSize Float : CGFloat , FontColor Color : UIColor , SnapTarget View : UIView){
        LB.text = Str
        LB.font = .boldSystemFont(ofSize: Float)
        LB.textAlignment = .center
        LB.textColor = Color
        self.view.addSubview(LB)
        
        LB.snp.makeConstraints { make in
            if LB == NameLable || LB == UrlIndexLabel || LB == AccountIndexLable{
                make.top.equalTo(View.snp.bottom).offset(20)
            }else if LB == AccountLable{
                make.top.equalTo(View.snp.bottom).offset(40)
            }else{
                make.top.equalTo(View.snp.bottom).offset(30)
            }
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(20)
        }
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
    }
    
    @objc func EditBtnAction(sender:UIButton){
            let AlertController = UIAlertController(title: "Option", message: "", preferredStyle: .actionSheet)
            let EditAction = UIAlertAction(title: "Edit", style: .default) { UIAlertAction in
                    let vc = AddPageViewController()
                    vc.HomeDelegate = self.HomeDelegate
                    vc.DetailDelegate = self
                    vc.EditModel = self.ModelData
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc , animated: true)
                
            }
            let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { Action in
                let AC = UIAlertController(title: "Warning" , message: "Do You Want Delete This Data?", preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.HomeDelegate?.RemoveListCell(ListData: self.ModelData)
                    self.dismiss(animated: true)
                }
                let Cancel = UIAlertAction(title: "Cancel", style: .default)
                AC.addAction(OK)
                AC.addAction(Cancel)
                self.present(AC , animated: true)
            }
            let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            AlertController.addAction(EditAction)
            AlertController.addAction(DeleteAction)
            AlertController.addAction(CancelAction)
            present(AlertController , animated: true)
    }
    
    @objc func TFLeftBtnAction(sender : UIButton){
        if sender.isSelected{
            PasswordTF.isSecureTextEntry = false
            TFLeftBtn.isSelected = false
        }else if sender.isSelected == false{
            PasswordTF.isSecureTextEntry = true
            TFLeftBtn.isSelected = true
        }
    }
    
    @objc func TFRightBtnAction(sender : UIButton){
        let AlertController = UIAlertController(title: "", message: "Password Copied", preferredStyle: .alert)
        let Action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            UIPasteboard.general.string = self.PasswordTF.text
        }
        AlertController.addAction(Action)
        present(AlertController , animated: true)
    }
    
    @objc func UrlBtnAction(sender : UIButton){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == PasswordTF{
            return false
        }else{
            return true
        }
    }
    
    func UpdateData(NewData Data : ListDataModel){
        NameLable.text = Data.Name
        CategoryBtn.setTitle(Data.Category, for: .normal)
        AccountIndexLable.text = Data.Account
        PasswordTF.text = Data.Password
        UrlIndexLabel.text = Data.Url
        CommentTV.text = Data.Comment
        ModelData = Data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
}
