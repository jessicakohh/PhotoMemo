//
//  User.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

struct UserModel {
    var username: String
    let email: String
    let uid: String
    var profileImageUrl: String?

    init(username: String, email: String, uid: String, profileImageUrl: String?) {
        self.username = username
        self.email = email
        self.uid = uid
        self.profileImageUrl = profileImageUrl
    }
}
