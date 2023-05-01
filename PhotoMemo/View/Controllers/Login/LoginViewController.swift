//
//  LoginViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
    }
    
    override func loadView() {
        view = loginView
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    private func configureDelegate() {
        loginView.delegate = self
    }
}
    
    // MARK: - Layout Extension

extension LoginViewController: LoginViewDelegate {
    
    func registerButtonTapped(_ loginView: LoginView) {
        let controller = SignInViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
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
                print("뷰모델로그인 성공")
           
            }
        }
    }
}
