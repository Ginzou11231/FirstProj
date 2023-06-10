//
//  MoreTableCell.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/6/8.
//

import UIKit
import SnapKit

class MoreTableCell: UITableViewCell {
    
    var TitleLabel : UILabel!
    var Switch : UnitSwitch!
    var ImageView : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        ImageView = UIImageView()
        ImageView.image = UIImage(systemName: "chevron.right")
        ImageView.tintColor = .white
        self.addSubview(ImageView)
        ImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(20)
        }
        
        Switch = UnitSwitch()
        Switch.onTintColor = .systemYellow
        self.addSubview(Switch)
        Switch.snp.makeConstraints { make in
            make.centerY.equalTo(ImageView)
            make.right.equalToSuperview().offset(-50)
            make.width.equalTo(20)
        }
        
        TitleLabel = UILabel()
        TitleLabel.text = "123"
        TitleLabel.font = .boldSystemFont(ofSize: 18)
        TitleLabel.textColor = .white
        self.addSubview(TitleLabel)
        TitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ImageView)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(ImageView.snp.left)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
