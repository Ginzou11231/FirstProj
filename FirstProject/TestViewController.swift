//
//  TestViewController.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/12.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    var Textinput : UITextField!
    @IBOutlet weak var Text : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        Textinput = UITextField(frame: CGRect(x: 70, y: 100, width: 300, height: 60))
        self.view.addSubview(Textinput)

        
        Text.layer.cornerRadius = 30
        Text.backgroundColor = .blue
        
        Textinput.layer.cornerRadius = 30
        Textinput.backgroundColor = .white
        Textinput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 60))
        Textinput.leftViewMode = .always
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
