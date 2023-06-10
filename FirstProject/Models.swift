//
//  Models.swift
//  FirstProject
//
//  Created by 邱裕芳 on 2023/5/28.
//

import UIKit
import Foundation

class ListDataModel {
    var Image : UIImage?
    var Name , Category , Account , Password , Url , Comment: String?
}

struct ListDataStruct: Codable {
//    let Image : UIImage
    var Image : Data
    var Name , Category , Account , Password , Url , Comment: String
}
