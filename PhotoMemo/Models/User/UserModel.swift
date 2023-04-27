//
//  User.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

struct UserModel {
    var uid: String
    var username: String
    var email: String
    var profileImageUrl: String?
    
    init(username: String, email: String, uid: String, profileImageUrl: String? = nil) {
        self.username = username
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
    }
}
