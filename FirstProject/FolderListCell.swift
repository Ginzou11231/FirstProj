//
//  FolderListCell.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/29.
//

import UIKit
import SnapKit

class FolderListCell: UICollectionViewCell {
    
    var BackgroundView: UIView!
    var TitleLabel : UILabel!
    var OptionBtn : UIButton!
    
    override init(frame: CGRect) {
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
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
        
        TitleLabel = UILabel()
        TitleLabel.text = "123"
        TitleLabel.textColor = .white
        TitleLabel.textAlignment = .left
        TitleLabel.font = .systemFont(ofSize: 20)
        self.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(OptionBtn)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
