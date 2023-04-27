//
//  SingInViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/26.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewModel {
    
    // MARK: - Properties
    
    var email: String?
    var password: String?
    var username: String?
    var profileImage: UIImage?
    
    func registerUser(completion: @escaping (Error?) -> Void) {
        
        guard let email = email, let password = password, let username = username, let profileImage = profileImage else {
            return
        }
        
        let credentials = AuthCredentials(email: email, password: password, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            print("DEBUG : 가입 성공")
            print("DEBUG : 사용자 업데이트 성공")
        }
    }
    
    
    // MARK: - Helpers
    
    
    
}


