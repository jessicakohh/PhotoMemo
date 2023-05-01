//
//  ResetViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit
import Firebase

final class ResetPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let resetPasswordView = ResetPasswordView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDelegate()
        configureNavigation()
    }
    
    override func loadView() {
        view = resetPasswordView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureDelegate() {
        resetPasswordView.delegate = self
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .mainDarkGrey
    }
}
    
    // MARK: - Extension

extension ResetPasswordViewController: ResetPasswordViewDelegate {
    func resetButtonTapped(_ resetPasswordView: ResetPasswordView) {
        guard let email = resetPasswordView.emailTextField.text else { return }

          Auth.auth().sendPasswordReset(withEmail: email) { error in
              if let error = error {
                  print("Failed to send password reset email: \(error.localizedDescription)")
                  // 에러 메시지를 사용자에게 보여주거나 다른 작업을 수행할 수 있습니다.
                  resetPasswordView.resultLabel.text = "🧣 입력하신 이메일이 존재하지 않습니다."
              } else {
                  print("Password reset email has been sent successfully")
                  resetPasswordView.resultLabel.text = " 💌 암호 재설정 메일이 전송되었습니다."
                  resetPasswordView.resultLabel.textColor = .mainDarkGrey
                  // 비밀번호 재설정 이메일이 성공적으로 전송되었음을 사용자에게 알리거나 다른 작업을 수행할 수 있습니다.
              }
          }
        
    }
}
