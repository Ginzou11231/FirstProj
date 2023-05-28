//
//  Page1ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

protocol HomePageDelegate{
    func AddCell(AddPageModel Model : AddPageModel)
}

class HomePageViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , HomePageDelegate  {
    
    var CategoryCollection , ListCollection : UICollectionView!
    var CategoryFlowLayout , ListFlowLayout : UICollectionViewFlowLayout!
    
    var CategoryArray: [String] = []
    var FolderArray : [String] = ["a","b","c","d","e","f","g","h","i","j","k"]
    var ListArray : [AddPageModel] = []
    var ShowLine : [Bool] = []
    
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
    }
    
    func AddCell(AddPageModel Model : AddPageModel){
        ListArray.append(Model)
        ListCollection.reloadData()
    }
    
    @objc func NavRightBtnAction(){
        if let vc = storyboard?.instantiateViewController(identifier: "AddPage") as? AddViewController{
            vc.HomeDelegate = self
            vc.modalPresentationStyle = .fullScreen
            present(vc , animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIInit()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let select = IndexPath(item: 0, section: 0)
        collectionView(CategoryCollection, didSelectItemAt: select)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CategoryCollection{
            CategoryArray = []
            CategoryArray.append("ALL")
            CategoryArray = CategoryArray + FolderArray
            for _ in 0..<CategoryArray.count{
                ShowLine.append(false)
            }
            return CategoryArray.count
        }else{
            return ListArray.count
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
            
            cell.TitleLabel.text = ListArray[indexPath.item].Name
            
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for a in 0..<ShowLine.count{
            ShowLine[a] = false
        }
        ShowLine[indexPath.item] = true
        collectionView.reloadData()
    }
}
