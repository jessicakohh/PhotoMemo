//
//  LoginViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit
import FirebaseAuth

class LoginViewModel {
    
//    let resultLogin = loginUser(email: , password: , completion: <#T##(Error?) -> Void#>)
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        AuthService.shared.logInUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG : 에러 \(error.localizedDescription)")
                completion(error)
                return
            }
            print("DEBUG : 로그인 성공")
            
            completion(nil)
        }
    }
}
