//
//  UserService.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/27.
//

import Firebase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            
        refUsers.child(uid).observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let uid = data["uid"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                let userModel = UserModel(username: username, email: email, uid: uid, profileImageUrl: imageUrl)
            }
        }
    }

}
