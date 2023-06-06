//
//  HomeListCell.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/28.
//

import UIKit
import SnapKit

class HomeListCell: UICollectionViewCell {
    
    var BackgroundView: UIView!
    var IconImageView : UIImageView!
    var TitleLabel : UILabel!
    var CopyBtn , OptionBtn : UIButton!
    
    override init(frame : CGRect){
        super.init(frame : frame)
        BackgroundView = UIView()
        BackgroundView.backgroundColor = UIColor(cgColor: CGColor(red: 175 / 255, green: 175 / 255, blue: 175 / 255, alpha: 0.5))
        BackgroundView.layer.cornerRadius = 10
        self.addSubview(BackgroundView)
        BackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(80)
        }
        
        OptionBtn = UIButton()
        OptionBtn.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        OptionBtn.tintColor = .systemYellow
        self.addSubview(OptionBtn)
        OptionBtn.snp.makeConstraints { make in
            make.top.equalTo(BackgroundView.snp.top)
            make.right.equalTo(BackgroundView.snp.right)
            make.bottom.equalTo(BackgroundView.snp.bottom)
            make.width.equalTo(60)
        }
        
        CopyBtn = UIButton()
        CopyBtn.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        CopyBtn.tintColor = .white
        self.addSubview(CopyBtn)
        CopyBtn.snp.makeConstraints { make in
            make.top.equalTo(BackgroundView.snp.top)
            make.right.equalTo(OptionBtn.snp.left)
            make.bottom.equalTo(BackgroundView.snp.bottom)
            make.width.equalTo(60)
        }
        
        IconImageView = UIImageView()
        IconImageView.image = UIImage(named: "Searchimage")
        IconImageView.layer.cornerRadius = 40
        self.addSubview(IconImageView)
        IconImageView.snp.makeConstraints { make in
            make.top.equalTo(BackgroundView.snp.top).offset(15)
            make.left.equalTo(BackgroundView.snp.left).offset(15)
            make.bottom.equalTo(BackgroundView.snp.bottom).offset(-15)
            make.width.equalTo(50)
        }
        
        TitleLabel = UILabel()
        TitleLabel.text = "123"
        TitleLabel.textColor = .white
        TitleLabel.textAlignment = .left
        TitleLabel.font = .systemFont(ofSize: 20)
        self.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.top.equalTo(IconImageView.snp.top)
            make.left.equalTo(IconImageView.snp.right).offset(10)
            make.right.equalTo(CopyBtn.snp.left)
            make.bottom.equalTo(IconImageView.snp.bottom)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
