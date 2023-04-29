//
//  editViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/24.
//

import UIKit

final class EditViewController: UIViewController {
    
    // MARK: - Properties
    
    var editView = EditView()
    private var userModel: UserModel?
    var viewModel = SettingViewModel()
    private let imagePicker = UIImagePickerController()
    
    // MARK: - LifeCycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        editView.delegate = self
        
        viewModel.fetchUser { [weak self] userModel in
            self?.configureUI()
        }
        
    }
    
    override func loadView() {
        view = editView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {
        DispatchQueue.main.async { [weak self] in
            guard let userModel = self?.viewModel.userModel else { return }
            self?.editView.nameTextField.text = userModel.username
            self?.editView.profileImage.image = UIImage(named: "daefaultImage")
            
            self?.viewModel.downloadProfileImage { image in
                DispatchQueue.main.async {
                    self?.editView.profileImage.image = image
                }
            }
        }
    }
    
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Layout Extension
}

extension EditViewController: EditViewDelegate {
    func openImagePickerTapped(_ editView: EditView) {
        openImagePicker()
    }
    
    func updateUserInfo(_ editView: EditView) {
        print("수정하기 버튼탭")
        guard let username = editView.nameTextField.text else { return }
        guard let image = editView.profileImage.image else { return }
        UserService.shared.updateProfileImage(image: image) { profileImageUrl in
            guard let profileImageUrl = profileImageUrl else { return }
            self.userModel?.profileImageUrl = profileImageUrl.absoluteString
            
            UserService.shared.updateUsername(username) { error, ref in
                if let error = error {
                    print("Failed to update username with error: ", error.localizedDescription)
                    return
                }
                self.userModel?.username = username
                print("Successfully updated username.")
                
                    self.popViewController()
                
            }
        }
    }
}




// MARK: - UIImagePicker

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
           if let photoImage = info[.editedImage] as? UIImage {
               self.editView.profileImage.image = photoImage
           }
           picker.dismiss(animated: true, completion: nil)
    }
}
