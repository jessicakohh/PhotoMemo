//
//  AuthManager.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthManager {
    
    static let shared = AuthManager()
    
    var userModel: UserModel? {
        didSet {
            print("유저모델")
        }
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { userModel in
            self.userModel = userModel
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    rootViewController.present(nav, animated: true, completion: nil)
                }
            }
            print("DEBUG : 유저가 로그인하지 않았습니다.")
        } else {
            fetchUser()
            print("DEBUG : 유저가 로그인했습니다")
        }
    }
    
    
    func logUserOut(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let error {
            print("DEBUG : 로그아웃 실패 \(error.localizedDescription)")
            completion(false)
        }
    }
    
    
}

