//
//  UserJSONDBModel.swift
//  PersonalColor_Swift
//
//  Created by WOOKHYUN on 2023/09/21.
//

import Foundation


// For JSON Decoding
// db 의 column 과 똑같아야함
// 불러올 값의 키 값과 똑같이 만들어야한다.

class UserResult : Codable{
    //     key        value
    let results : [UserJSON]
}


// Codable 상속받기
class UserJSON : Codable{
    // 순서도 똑같이 하기
    //   key     value
    var uid : String
    var upassword : String
    var ustatus : Int
    var ucolor : Int
    var uinsertdate : String
    var udeletedate : String
    var uname : String
}

