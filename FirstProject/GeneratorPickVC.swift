//
//  GeneratorPickVC.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/6/6.
//

import UIKit
import SnapKit

class GeneratorPickVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {

    var PickerView : UIPickerView!
    var CancelBtn , OKBtn : UIButton!
    
    var Length : [Int] = []
    var SelectLength : Int = 0
    
    var GeneratorDelegate : GeneratorPageDelegate!
    
    @objc func CancelBtnAction(sender : UIButton){
        dismiss(animated: true)
    }
    
    @objc func OKBtnAction(sender : UIButton){
        GeneratorDelegate.SetLength(Length: SelectLength)
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        
        CancelBtn = UIButton()
        CancelBtn.setTitle("Cancel", for: .normal)
        CancelBtn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        CancelBtn.tintColor = .white
        CancelBtn.backgroundColor = .clear
        CancelBtn.addTarget(self, action: #selector(CancelBtnAction(sender: )), for: .touchUpInside)
        self.view.addSubview(CancelBtn)
        CancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        OKBtn = UIButton()
        OKBtn.setTitle("OK", for: .normal)
        OKBtn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        OKBtn.tintColor = .white
        OKBtn.backgroundColor = .clear
        OKBtn.addTarget(self, action: #selector(OKBtnAction(sender: )), for: .touchUpInside)
        self.view.addSubview(OKBtn)
        OKBtn.snp.makeConstraints { make in
            make.top.equalTo(CancelBtn)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(CancelBtn)
            make.height.equalTo(CancelBtn)
        }
        
        PickerView = UIPickerView()
        PickerView.delegate = self
        PickerView.dataSource = self
        PickerView.layer.borderColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        PickerView.layer.borderWidth = 0.75
        self.view.addSubview(PickerView)
        PickerView.snp.makeConstraints { make in
            make.top.equalTo(CancelBtn.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(1)
        }
    
        for i in 0...15{
            Length.append(i)
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Length.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var Label = UILabel()
        
        if let v = view as? UILabel{
            Label = v
        }

        Label.text = String(Length[row])
        Label.font = .boldSystemFont(ofSize: 30)
        Label.textAlignment = .center
        Label.textColor = .white
        
        return Label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectLength = Length[row]
    }
    
}
