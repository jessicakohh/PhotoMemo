//
//  PhotoDetailViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/19.
//

import UIKit
import RealmSwift

final class PhotoDetailViewController: UIViewController {
    
    // MARK: - Properties
    var photoDetailView = PhotoDetailView()
    var calendarData: CalendarData?
    private let viewModel = PhotoDetailViewModel()
    private let imagePicker = UIImagePickerController()
    
    var realmManager = RealmManager()


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoDetailView.delegate = self

        configureNavigation()
        configureUI()
    }
    
    override func loadView() {
        view = photoDetailView
    }
    
    // MARK: - Selectors
    
    @objc func deleteButtonTapped() {
    }
    
    @objc func saveButtonTapped() {
        guard let date = photoDetailView.dateLabel.text else { return }
    }
    
    // MARK: - Helpers
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .mainDarkGrey
        
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named: "deleteButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        let deleteBarButtonItem = UIBarButtonItem(customView: deleteButton)
        
        let saveButton = UIButton(type: .custom)
        saveButton.setImage(UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let saveBarButtonItem = UIBarButtonItem(customView: saveButton)

        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 10

        
        navigationItem.rightBarButtonItems = [saveBarButtonItem, space, deleteBarButtonItem]
    }
    
    private func configureUI() {
        if let imageData = calendarData?.image {
            photoDetailView.photoImageView.image = UIImage(data: imageData)
        }
    }
    
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}




// MARK: - ImagePicker

extension PhotoDetailViewController: PhotoDetailViewDelegate {
    func openImagePickerTapped(_ photoDetailView: PhotoDetailView) {
        openImagePicker()
    }
}

extension PhotoDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
           if let photoImage = info[.editedImage] as? UIImage {
               self.photoDetailView.photoImageView.image = photoImage
           }
           picker.dismiss(animated: true, completion: nil)
    }
}
