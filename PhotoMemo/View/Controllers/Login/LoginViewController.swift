//
//  LoginViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
    }
    
    override func loadView() {
      view = loginView
  }
    
    // MARK: - Selectors
    

    
    // MARK: - Helpers
    
    
    // MARK: - Layout Extension
}

extension LoginViewController: LoginViewDelegate {
    
    func handleShowSignUp() {
         let controller = PhotoViewController()
         navigationController?.pushViewController(controller, animated: true)
     }
 
    func loginViewDidTapLoginButton(_ loginView: LoginView) {
        
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextField.text else {
            return
        }
        
        viewModel.loginUser(email: email, password: password) { error in
            if let error = error {
                print("로그인 에러:", error.localizedDescription)
            } else {
                print("로그인 성공")
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
                guard let tab = window.rootViewController as? PhotoViewController else { return }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
