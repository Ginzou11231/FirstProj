//
//  CreateFolderPage.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/29.
//

import UIKit
import SnapKit

class CreateFolderViewController: UIViewController {
    
    var FolderDelegate : FolderPageDelegate?
    
    var EditData : String!
    var isReEdit : Bool = false
    
    var BackBtn , AddBtn : UIButton!
    var TitleLabel : UILabel!
    var BackgroundImageView : UIImageView!
    var BackgroundView : UIView!
    var FolderNameTF : UnitTextField!
    
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
        TitleLabel.text = "Create Folder"
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
        
        FolderNameTF = UnitTextField()
        FolderNameTF.backgroundColor = .white
        FolderNameTF.layer.cornerRadius = 20
        FolderNameTF.placeholder = "Folder Name"
        FolderNameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))
        FolderNameTF.leftViewMode = .always
        self.view.addSubview(FolderNameTF)
        
        FolderNameTF.snp.makeConstraints { make in
            make.top.equalTo(BackgroundView).offset(40)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(40)
        }
        
        AddBtn = UIButton()
        AddBtn.layer.cornerRadius = 20
        AddBtn.setTitle("A D D", for: .normal)
        AddBtn.setTitleColor(.black, for: .normal)
        AddBtn.setTitleColor(.lightGray, for: .highlighted)
        AddBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        AddBtn.backgroundColor = .systemYellow
        
        AddBtn.addTarget(self, action: #selector(AddBtnAction(sender:)), for: .touchUpInside)
        BackgroundView.addSubview(AddBtn)
        AddBtn.snp.makeConstraints { make in
            make.bottom.equalTo(BackgroundView).offset(-20)
            make.left.equalTo(BackgroundView).offset(20)
            make.right.equalTo(BackgroundView).offset(-20)
            make.height.equalTo(40)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func BackBtnAction(sender:UIButton){
        dismiss(animated: true)
    }
    
    @objc func AddBtnAction(sender : UIButton){
        
        self.view.endEditing(true)
        
        if let check = FolderNameTF.text?.isEmpty , check{
            let AlertController = UIAlertController(title: "Error", message: "Folder Name is Empty", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title: "OK", style: .default)
            AlertController.addAction(AlertAction)
            present(AlertController , animated: true)
        }
        
        if let check = FolderDelegate?.CheckListCell(FolderName: FolderNameTF.text!) , check{
            let AlertController = UIAlertController(title: "Alert", message: "This FolderName Already in Listdata\nPlease Change Another Name", preferredStyle: .alert)
            let AlertAction = UIAlertAction(title: "OK", style: .default)
            AlertController.addAction(AlertAction)
            present(AlertController , animated: true)
        }else{
            if isReEdit{
                let AlertController = UIAlertController(title: "", message: "Folder Updata Complete", preferredStyle: .alert)
                let AlertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.FolderDelegate?.UpdateListCell(EditDataName: self.EditData, NewDataName: self.FolderNameTF.text!)
                    self.dismiss(animated: true)
                }
                AlertController.addAction(AlertAction)
                present(AlertController , animated: true)
            }else{
                let AlertController = UIAlertController(title: "", message: "Folder Created Complete", preferredStyle: .alert)
                let AlertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                    self.FolderDelegate?.AddListCell(FolderName: self.FolderNameTF.text!)
                    self.dismiss(animated: true)
                }
                AlertController.addAction(AlertAction)
                present(AlertController , animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
        if EditData != nil{
            FolderNameTF.text = EditData
            AddBtn.setTitle("UPDATE", for: .normal)
            isReEdit = true
        }

    }
}
