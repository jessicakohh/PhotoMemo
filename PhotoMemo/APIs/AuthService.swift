//
//  AuthService.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/27.
//

import UIKit
import Firebase
import FirebaseAuth

// 이메일, 비밀번호, 사용자 이름, 프로필 이미지 등을 사용하여 사용자를 등록하거나 로그인

struct AuthCredentials {
    let email: String
    let password: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logInUser(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = storageProfileImages.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            
            if let error = error {
                print("DEBUG: Failed to upload image to storage with error \(error.localizedDescription)")
                completion(error, refUsers)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {
                    print("DEBUG: Failed to get download URL")
                    completion(error, refUsers)
                    return
                }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("DEBUG: Failed to create user with error \(error.localizedDescription)")
                        completion(error, refUsers)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {
                        print("DEBUG: Failed to get user ID")
                        completion(nil, refUsers)
                        return
                    }
                    
                    let values = ["email": email,
                                  "username": username,
                                  "profileImageUrl": profileImageUrl]
                    
                    refUsers.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
    
  
}
