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
    
    func authenticateUser(completion: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                    rootViewController.present(nav, animated: true, completion: nil)
                }
            }
            print("DEBUG : 유저가 로그인하지 않았습니다.")
            completion(false)
        } else {
            print("DEBUG : 유저가 로그인했습니다")
            completion(true)
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
