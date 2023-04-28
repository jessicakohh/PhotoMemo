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

    // 기본적으로 선택한 이미지에 값이 있으면 이미지가 변경되었음을 의미
    private var imageChanged: Bool {
        return selectedImage != nil
    }
    
    private var selectedImage: UIImage? {
        didSet { editView.profileImage.image = selectedImage }
    }

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
    
    // MARK: - Layout Extension
}

extension EditViewController: EditViewDelegate {
    
    func updateUserInfo(_ editView: EditView) {
        print("수정하기 버튼탭")
        guard let username = editView.nameTextField.text else { return }
        guard let image = selectedImage else { return }
        UserService.shared.updateProfileImage(image: image) { profileImageUrl in
            self.userModel?.profileImageUrl = String(describing: profileImageUrl)
        }
    }
    
}


// MARK: - UIImagePicker

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        self.selectedImage = image
        
        dismiss(animated: true)
    }
}

