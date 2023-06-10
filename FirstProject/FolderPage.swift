//
//  Page2ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

protocol FolderPageDelegate{
    func CheckListCell(FolderName Name : String) -> Bool
    func AddListCell(FolderName Name : String)
    func UpdateListCell(EditDataName Data : String , NewDataName NewData : String)
    func DeleteListCell(DeleteData Data : String)
}

class FolderPageViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , FolderPageDelegate{

    var ListCollection : UICollectionView!
    var ListFlowLayout : UICollectionViewFlowLayout!
    var NoDataLabel : UILabel!
    var NoDataImageView : UIImageView!
    
    var FolderArray : [String] = []
    
    func UIInit(){
        navigationItem.title = "FOLDER"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24) ,NSAttributedString.Key.foregroundColor : UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(NavRightBtnAction))
        navigationItem.rightBarButtonItem?.tintColor = .orange
                
        ListFlowLayout = UICollectionViewFlowLayout()
        ListFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        ListFlowLayout.itemSize = CGSizeMake(UIScreen.main.bounds.width - 20, 80)
        ListFlowLayout.scrollDirection = .vertical
        
        ListCollection = UICollectionView(frame: CGRect(), collectionViewLayout: ListFlowLayout)
        ListCollection.register(FolderListCell.self, forCellWithReuseIdentifier: "FolderListCell")
        ListCollection.showsVerticalScrollIndicator = false
        ListCollection.backgroundColor = .clear
        ListCollection.dataSource = self
        ListCollection.delegate = self
        self.view.addSubview(ListCollection)
        ListCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        NoDataImageView = UIImageView()
        NoDataImageView.image = UIImage(named: "icon_*")
        self.view.addSubview(NoDataImageView)
        NoDataImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        NoDataLabel = UILabel()
        NoDataLabel.text = "Haven't Any Data"
        NoDataLabel.font = .boldSystemFont(ofSize: 20)
        NoDataLabel.textColor = .white
        NoDataLabel.textAlignment = .center
        self.view.addSubview(NoDataLabel)
        NoDataLabel.snp.makeConstraints { make in
            make.top.equalTo(NoDataImageView.snp.bottom).offset(20)
            make.left.equalTo(ListCollection)
            make.right.equalTo(ListCollection)
        }
    }

    @objc func NavRightBtnAction(){
        let vc = CreateFolderViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.FolderDelegate = self
        present(vc , animated: true)
    }
    
    func CheckListCell(FolderName Name: String) -> Bool {
        for indexs in FolderArray {
            if indexs == Name{
                return true
            }
        }
        return false
    }
    
    func AddListCell(FolderName Name: String) {
        FolderArray.append(Name)
        SaveData()
        ListCollection.reloadData()
        
        if let indexs = tabBarController?.viewControllers?[0] as? UINavigationController{
            if let datas = indexs.topViewController as? HomePageViewController{
                datas.CategoryCollection.reloadData()
            }
        }
    }
    
    func UpdateListCell(EditDataName Data : String , NewDataName NewData : String){
        for indexs in 0..<FolderArray.count{
            if FolderArray[indexs] == Data{
                FolderArray[indexs] = NewData
                ListCollection.reloadData()
                SaveData()
                break
            }
        }
        
        if let indexs = tabBarController?.viewControllers?[0] as? UINavigationController{
            if let datas = indexs.topViewController as? HomePageViewController{
                for indexs in 0..<datas.ListArray.count{
                    if datas.ListArray[indexs].Category == Data{
                        datas.ListArray[indexs].Category = NewData
                        datas.SaveData()
                    }
                }
                datas.CategoryCollection.reloadData()
            }
        }
    }
    
    func DeleteListCell(DeleteData Data : String){
        for indexs in 0..<FolderArray.count{
            if FolderArray[indexs] == Data{
                FolderArray.remove(at: indexs)
                ListCollection.reloadData()
                SaveData()
                break
            }
        }
        
        if let indexs = tabBarController?.viewControllers?[0] as? UINavigationController{
            if let datas = indexs.topViewController as? HomePageViewController{
                var array : [ListDataModel] = []
                
                for indexs in 0..<datas.ListArray.count{
                    if datas.ListArray[indexs].Category != Data{
                        array.append(datas.ListArray[indexs])
                    }
                }
                datas.ListArray = array
                datas.collectionView(datas.CategoryCollection, didSelectItemAt: IndexPath(item: 0, section: 0))
                datas.SaveData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    
    func SaveData(){
        UserDefaults.standard.set(FolderArray, forKey: "Folders")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if FolderArray.count == 0{
            NoDataLabel.isHidden = false
            NoDataImageView.isHidden = false
        }else{
            NoDataLabel.isHidden = true
            NoDataImageView.isHidden = true
        }
        
        return FolderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderListCell", for: indexPath) as! FolderListCell
        cell.TitleLabel.text = FolderArray[indexPath.item]
        cell.OptionBtn.tag = indexPath.item
        cell.OptionBtn.addTarget(self, action: #selector(OptionBtnAction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func OptionBtnAction(sender : UIButton){
        let AlertController = UIAlertController(title: "Option", message: "", preferredStyle: .actionSheet)
        let EditAction = UIAlertAction(title: "Edit", style: .default) { UIAlertAction in
            let vc = CreateFolderViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.FolderDelegate = self
            vc.EditData = self.FolderArray[sender.tag]
            self.present(vc , animated: true)
        }
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { Action in
            let AC = UIAlertController(title: "Warning" , message: "If You Delete This Folder\nWill Delete Data In This Folder\nAre You Sure Delete Folder?", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                if let vc = self.storyboard?.instantiateViewController(identifier: "LoginPage") as? LoginPageViewController{
                    
                    vc.modalPresentationStyle = .fullScreen
                    vc.DeleteData = self.FolderArray[sender.tag]
                    vc.FolderDelegate = self
                    vc.PrevPageInt = PrevPageEnum.Folder.rawValue
                    self.present(vc , animated: true)
                }
                
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
}
