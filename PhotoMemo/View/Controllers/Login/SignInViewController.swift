//
//  SignViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    private let signInView = SignInView()
    private let viewModel = SignInViewModel()
    private let imagePicker = UIImagePickerController()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureDelegate()
    }
    
    override func loadView() {
        view = signInView
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .mainDarkGrey
    }
    
    private func configureDelegate() {
        signInView.delegate = self
    }
}

// MARK: - SingInViewDelegate

extension SignInViewController: SignInViewDelegate {
    
    func openImagePickerTapped(_ signInView: SignInView) {
        openImagePicker()
    }
    
    
    func joinButtonTapped(_ singInView: SignInView) {
        
        guard let profileImage = signInView.profileImageView.image else {
            print("DEBUG: Please select a profile image / 프로필 이미지를 선택하십시오")
            return
        }
        guard let email = signInView.emailTextField.text else { return }
        guard let password = signInView.passwordTextField.text else { return }
        guard let username = signInView.nameTextField.text else { return }
        
        viewModel.email = email
        viewModel.password = password
        viewModel.username = username
        viewModel.profileImage = signInView.profileImageView.image
        
        viewModel.registerUser { error in
            if let error = error {
                print("DEBUG: Error registering user with error \(error.localizedDescription)")
            } else {
                print("DEBUG : 가입 성공")
                print("DEBUG : 사용자 업데이트 성공")
                let controller = PhotoViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

extension SignInViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let profileImage = info[.editedImage] as? UIImage {
            self.signInView.profileImageView.image = profileImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
}
