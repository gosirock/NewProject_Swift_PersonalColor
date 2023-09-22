//
//  UserDBModel.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation
// db column과  달라도 됌
// User Model

class UserDBModel{
    
    // property
    var uid : String
    var upassword : String
    var ustatus : Int
    var ucolor : Int
    var uinsertdate : String
    var udeletedate : String
    var uname : String
    
    
    init(uid: String, upassword: String, ustatus: Int, ucolor: Int, uinsertdate: String, udeletedate: String, uname: String) {
        self.uid = uid
        self.upassword = upassword
        self.ustatus = ustatus
        self.ucolor = ucolor
        self.uinsertdate = uinsertdate
        self.udeletedate = udeletedate
        self.uname = uname
    }
    
}
