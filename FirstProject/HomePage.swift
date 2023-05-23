//
//  Page1ViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/15.
//

import UIKit
import SnapKit

class HomePageViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    var CategoryCollection : UICollectionView!
    var FlowLayout : UICollectionViewFlowLayout!
    
    var CategoryArray: [String] = ["All"]
    var FolderArray : [String] = ["a","b","c","d","e","f","g","h","i","j","k"]
    var ShowLine : [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryArray = CategoryArray + FolderArray
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo_h"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(NavRightBtnAction))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        
        FlowLayout = UICollectionViewFlowLayout()
        FlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        FlowLayout.itemSize = CGSizeMake(UIScreen.main.bounds.width / 5 - 10, 50)
        FlowLayout.scrollDirection = .horizontal
        
        CategoryCollection = UICollectionView(frame: CGRect(), collectionViewLayout: FlowLayout)
        CategoryCollection.register(HomeCollectionCell.self, forCellWithReuseIdentifier: "CategoryCell")
        CategoryCollection.showsHorizontalScrollIndicator = false
        CategoryCollection.bounces = false
        CategoryCollection.backgroundColor = .clear
        CategoryCollection.delegate = self
        CategoryCollection.dataSource = self
        self.view.addSubview(CategoryCollection)
        
        CategoryCollection.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }

}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let select = IndexPath(item: 0, section: 0)
        collectionView(CategoryCollection, didSelectItemAt: select)
        
    }
    
    @objc func NavRightBtnAction(){
        if let vc = storyboard?.instantiateViewController(identifier: "AddPage") as? AddViewController{
            vc.modalPresentationStyle = .fullScreen
            present(vc , animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        for _ in 0..<CategoryArray.count{
            ShowLine.append(false)
        }
        return CategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! HomeCollectionCell
        
        if ShowLine[indexPath.item]{
            cell.UnderLine.backgroundColor = .systemYellow
        }else{
            cell.UnderLine.backgroundColor = .clear
        }
        
        cell.Label.text = CategoryArray[indexPath.item]

        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for a in 0..<ShowLine.count{
            ShowLine[a] = false
        }
        ShowLine[indexPath.item] = true
        collectionView.reloadData()
    }
}
