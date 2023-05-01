//
//  AuthManager.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// 현재 로그인된 사용자를 확인, 해당 사용자의 정보를 가져옴

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
            self.userModel = nil
            completion(true)
        } catch let error {
            print("DEBUG : 로그아웃 실패 \(error.localizedDescription)")
            completion(false)
        }
    }

    func deleteCurrentUser(completion: @escaping (Bool) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false)
            return
        }
        currentUser.delete { error in
            if let error = error {
                print("DEBUG: 회원 탈퇴 실패 \(error.localizedDescription)")
                completion(false)
            } else {
                do {
                    try Auth.auth().signOut()
                    self.userModel = nil
                    completion(true)
                } catch let error {
                    print("DEBUG : 로그아웃 실패 \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
    
    func resetPassword(forEmail email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                // 이메일 조회 중 에러 발생
                completion(error)
            } else if let methods = methods, methods.isEmpty {
                // 이메일이 존재하지 않음
                completion(NSError(domain: "auth", code: 17011, userInfo: [NSLocalizedDescriptionKey: "이메일이 존재하지 않습니다."]))
            } else {
                // 이메일이 존재하면 비밀번호 재설정 메일 보내기
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    completion(error)
                }
            }
        }
    }

}

