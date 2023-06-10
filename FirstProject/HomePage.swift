//
//  Page1ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

protocol HomePageDelegate{
    func CheckCategoryCell(CategoryName Name : String) -> Bool
    func AddCategoryCell(CategoryName Name : String)
    func CheckListCell(ListName Name : String) -> Bool
    func UpdateListCell(NewData Model : ListDataModel)
    func AddListCell(AddPageModel Model : ListDataModel)
    func RemoveListCell(ListData Data : ListDataModel)
    func CheckFolderSameData(ListData Data : ListDataModel) -> Bool
    func ReEditListCell(EditDataModel Model : ListDataModel , NewDataModel NewModel : ListDataModel)
    func OverrideListCell(EditDataModel Model : ListDataModel , NewDataModel NewModel : ListDataModel)
}

class HomePageViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , HomePageDelegate  {
    
    var CategoryCollection , ListCollection : UICollectionView!
    var CategoryFlowLayout , ListFlowLayout : UICollectionViewFlowLayout!
    
    var CategoryArray: [String] = []
    var ShowLine : [Bool] = []
    var FirstTime = true
    
    var SelectListArray : [ListDataModel] = []
    var ListArray : [ListDataModel] = []
    
    var NoDataImageView : UIImageView!
    var NoDataLabel : UILabel!
    
    
    func UIInit(){
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo_h"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(NavRightBtnAction))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        
        CategoryFlowLayout = UICollectionViewFlowLayout()
        CategoryFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        CategoryFlowLayout.itemSize = CGSizeMake(UIScreen.main.bounds.width / 5 - 10, 50)
        CategoryFlowLayout.scrollDirection = .horizontal
        
        CategoryCollection = UICollectionView(frame: CGRect(), collectionViewLayout: CategoryFlowLayout)
        CategoryCollection.register(HomeCategoryCell.self, forCellWithReuseIdentifier: "HomeCategoryCell")
        CategoryCollection.showsHorizontalScrollIndicator = false
        CategoryCollection.bounces = false
        CategoryCollection.backgroundColor = .clear
        CategoryCollection.delegate = self
        CategoryCollection.dataSource = self
        self.view.addSubview(CategoryCollection)
        
        CategoryCollection.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }
        
        ListFlowLayout = UICollectionViewFlowLayout()
        ListFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        ListFlowLayout.itemSize = CGSizeMake(UIScreen.main.bounds.width - 20, 80)
        ListFlowLayout.scrollDirection = .vertical
        
        ListCollection = UICollectionView(frame: CGRect(), collectionViewLayout: ListFlowLayout)
        ListCollection.register(HomeListCell.self, forCellWithReuseIdentifier: "HomeListCell")
        ListCollection.showsVerticalScrollIndicator = false
        ListCollection.backgroundColor = .clear
        ListCollection.dataSource = self
        ListCollection.delegate = self
        self.view.addSubview(ListCollection)
        
        ListCollection.snp.makeConstraints { make in
            make.top.equalTo(CategoryCollection.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
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
        let vc = AddPageViewController()
        vc.HomeDelegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc , animated: true)
    }
    
    func CheckCategoryCell(CategoryName Name : String) -> Bool {
        if let indexs = tabBarController?.viewControllers?[1] as? UINavigationController{
            if let datas = indexs.topViewController as? FolderPageViewController{
                for indexs in datas.FolderArray{
                    if Name == indexs{
                        return false
                    }
                }
            }
        }
        return true
    }
    
    func AddCategoryCell(CategoryName Name : String ) {
        if let indexs = tabBarController?.viewControllers?[1] as? UINavigationController{
            if let datas = indexs.topViewController as? FolderPageViewController{
                datas.FolderArray.append(Name)
                datas.SaveData()
                if datas.ListCollection != nil{
                    datas.ListCollection.reloadData()
                }
            }
        }
        CategoryCollection.reloadData()
    }
    
    func CheckListCell(ListName Name : String) -> Bool {
        for indexs in ListArray{
            if Name == indexs.Name{
                return true
            }
        }
        return false
    }
    
    func AddListCell(AddPageModel Model : ListDataModel){
        ListArray.append(Model)
        SaveData()
        
        for indexs in 0..<ShowLine.count{
            if ShowLine[indexs] == true{
                collectionView(CategoryCollection, didSelectItemAt: IndexPath(item: indexs, section: 0))
                break
            }
        }
    }
    
    func UpdateListCell(NewData Model : ListDataModel){
        for indexs in 0..<ListArray.count{
            if ListArray[indexs].Category == Model.Category && ListArray[indexs].Name == Model.Name{
                ListArray[indexs] = Model
                SaveData()
                break
            }
        }
        
        for indexs in 0..<ShowLine.count{
            if ShowLine[indexs] == true{
                collectionView(CategoryCollection, didSelectItemAt: IndexPath(item: indexs, section: 0))
                break
            }
        }
    }
    
    func ReEditListCell(EditDataModel Model : ListDataModel , NewDataModel NewModel : ListDataModel){
        for indexs in 0..<ListArray.count{
            if ListArray[indexs].Category == Model.Category && ListArray[indexs].Name == Model.Name{
                ListArray[indexs] = NewModel
                SaveData()
                break
            }
        }
        
        for indexs in 0..<ShowLine.count{
            if ShowLine[indexs] == true{
                collectionView(CategoryCollection, didSelectItemAt: IndexPath(item: indexs, section: 0))
                break
            }
        }
    }
    
    func OverrideListCell(EditDataModel Model : ListDataModel , NewDataModel NewModel : ListDataModel){
        for indexs in 0..<ListArray.count{
            if ListArray[indexs].Name == Model.Name && ListArray[indexs].Category == Model.Category{
                ListArray.remove(at: indexs)
                break
            }
        }
        
        for indexs in 0..<ListArray.count{
            if ListArray[indexs].Name == NewModel.Name && ListArray[indexs].Category == NewModel.Category{
                ListArray[indexs] = NewModel
                SaveData()
                break
            }
        }
        
        for indexs in 0..<ShowLine.count{
            if ShowLine[indexs] == true{
                collectionView(CategoryCollection, didSelectItemAt: IndexPath(item: indexs, section: 0))
                break
            }
        }
    }
    
    func RemoveListCell(ListData Data : ListDataModel){
        for indexs in 0..<ListArray.count{
            if ListArray[indexs].Name == Data.Name && ListArray[indexs].Category == Data.Category{
                ListArray.remove(at: indexs)
                SaveData()
                break
            }
        }
        for indexs in 0..<ShowLine.count{
            if ShowLine[indexs] == true{
                collectionView(CategoryCollection, didSelectItemAt: IndexPath(item: indexs, section: 0))
                break
            }
        }
    }
    
    func CheckFolderSameData(ListData Data : ListDataModel) -> Bool {
        for indexs in ListArray{
            if indexs.Name == Data.Name && indexs.Category == Data.Category{
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
        
        if let datas = UserDefaults.standard.object(forKey: "Screenshot"){
            if let indexs = tabBarController?.viewControllers?[3] as? UINavigationController{
                if let vc = indexs.topViewController as? MorePageViewController{
                    vc.ScreenshotBool = datas as? Bool
                }
            }
        }

        if let datas = UserDefaults.standard.object(forKey: "Folders"){
            if let indexs = tabBarController?.viewControllers?[1] as? UINavigationController{
                if let vc = indexs.topViewController as? FolderPageViewController{
                    vc.FolderArray = datas as! [String]
                }
            }
        }

        if let datas = UserDefaults.standard.data(forKey: "Datas"){
            do {
                let decoder = JSONDecoder()
                let notes = try decoder.decode([ListDataStruct].self, from: datas)
                
                for i in 0..<notes.count{
                    let ListData = ListDataModel()
                    ListData.Image = UIImage(data: notes[i].Image)
                    ListData.Name = notes[i].Name
                    ListData.Category = notes[i].Category
                    ListData.Account = notes[i].Account
                    ListData.Password = notes[i].Password
                    ListData.Url = notes[i].Url
                    ListData.Comment = notes[i].Comment
                    ListArray.append(ListData)
                }
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        if FirstTime{
            let select = IndexPath(item: 0, section: 0)
            collectionView(CategoryCollection, didSelectItemAt: select)
            FirstTime = false
        }
    }
    

    func SaveData(){
        var Datas : [ListDataStruct] = []
        
        for i in 0..<ListArray.count{
            let data = ListDataStruct(Image: ListArray[i].Image!.pngData()!,
                                      Name: ListArray[i].Name!,
                                      Category: ListArray[i].Category!,
                                      Account: ListArray[i].Account!,
                                      Password: ListArray[i].Password!,
                                      Url: ListArray[i].Url!,
                                      Comment: ListArray[i].Comment!)
            Datas.append(data)
        }
        
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(Datas)
            UserDefaults.standard.set(data, forKey: "Datas")
        }catch{
            print("Unable to Encode Note (\(error))")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollection{
            CategoryArray = []
            CategoryArray.append("ALL")
            if let indexs = tabBarController?.viewControllers?[1] as? UINavigationController{
                if let datas = indexs.topViewController as? FolderPageViewController{
                    CategoryArray = CategoryArray + datas.FolderArray
                }
            }
            
            if ShowLine.count < CategoryArray.count
            {
                for _ in 0..<CategoryArray.count - ShowLine.count{
                    ShowLine.append(false)
                }
            }
            
            return CategoryArray.count
            
        }else{
            if SelectListArray.count == 0{
                NoDataLabel.isHidden = false
                NoDataImageView.isHidden = false
            }else{
                NoDataLabel.isHidden = true
                NoDataImageView.isHidden = true
            }
            return SelectListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CategoryCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as! HomeCategoryCell
            
            if ShowLine[indexPath.item]{
                cell.UnderLine.backgroundColor = .systemYellow
            }else{
                cell.UnderLine.backgroundColor = .clear
            }
            
            cell.Label.text = CategoryArray[indexPath.item]
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCell", for: indexPath) as! HomeListCell
            
            cell.TitleLabel.text = SelectListArray[indexPath.item].Name
            cell.IconImageView.image = SelectListArray[indexPath.item].Image
            cell.CopyBtn.tag = indexPath.item
            cell.CopyBtn.addTarget(self, action: #selector(CopyBtnAction(sender:)), for: .touchUpInside)
            cell.OptionBtn.tag = indexPath.item
            cell.OptionBtn.addTarget(self, action: #selector(OptionBtnAction(sender:)), for: .touchUpInside)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == CategoryCollection{
            
            for a in 0..<ShowLine.count{
                ShowLine[a] = false
            }
            ShowLine[indexPath.item] = true
            collectionView.reloadData()
            
            if indexPath.item == 0 {
                SelectListArray = ListArray
            }else{
                var array : [ListDataModel] = []
                let str = CategoryArray[indexPath.item]

                for Data in ListArray{
                    if str == Data.Category {
                        array.append(Data)
                    }
                }
                SelectListArray = array
            }
            ListCollection.reloadData()
            
        }else{
            let vc = HomeListDetailViewController()
            vc.HomeDelegate = self
            vc.ModelData = SelectListArray[indexPath.item]
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    

    
    @objc func CopyBtnAction(sender : UIButton){
        let AlertController = UIAlertController(title: "", message: "Password Copied", preferredStyle: .alert)
        let AlertAction = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            UIPasteboard.general.string = self.SelectListArray[sender.tag].Password
        }
        AlertController.addAction(AlertAction)
        present(AlertController , animated: true)
    }
    
    @objc func OptionBtnAction(sender : UIButton){
        let AlertController = UIAlertController(title: "Option", message: "", preferredStyle: .actionSheet)
        let EditAction = UIAlertAction(title: "Edit", style: .default) { UIAlertAction in
            let vc = AddPageViewController()
            vc.HomeDelegate = self
            vc.EditModel = self.SelectListArray[sender.tag]
            vc.modalPresentationStyle = .fullScreen
            self.present(vc , animated: true)
        }
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { Action in
            let AC = UIAlertController(title: "Warning" , message: "Do You Want Delete This Data?", preferredStyle: .alert)
            let OK = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
                self.RemoveListCell(ListData: self.SelectListArray[sender.tag])
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
