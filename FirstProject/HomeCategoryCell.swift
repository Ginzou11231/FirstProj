//
//  HomeCollectionCell.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/19.
//

import UIKit
import SnapKit




class HomeCategoryCell: UICollectionViewCell {
    
    var Label : UILabel!
    var UnderLine: UIView!
    
    override init (frame : CGRect){
        super.init(frame : frame)
        let w = Double(UIScreen.main.bounds.size.width)
        Label = UILabel(frame: CGRect(x: 0, y: 0, width: w / 5 - 10, height: 45))
        Label.textAlignment = .center
        Label.font = .boldSystemFont(ofSize: 20.0)
        Label.textColor = .systemYellow
        self.addSubview(Label)
        
        UnderLine = UIView()
        UnderLine.layer.cornerRadius = 2
        UnderLine.backgroundColor = .clear
        self.addSubview(UnderLine)
        UnderLine.snp.makeConstraints { make in
            make.top.equalTo(Label.snp.bottom).offset(2)
            make.centerX.equalTo(Label)
            make.width.equalTo(Label).offset(-15)
            make.height.equalTo(4)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
