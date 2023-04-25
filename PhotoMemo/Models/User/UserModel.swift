//
//  User.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

struct UserModel {
    var name: String
    var email: String
    var uid: String
    var profileImageUrl: String?
    
    init(name: String, email: String, uid: String, profileImageUrl: String? = nil) {
        self.name = name
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
    }
}
