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
    private var calendarData: CalendarData?
    private let viewModel = PhotoDetailViewModel()
    private let imagePicker = UIImagePickerController()
    private var realmManager = RealmManager()


    // MARK: - LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDelegate()
        configureNavigation()
    }
    
    override func loadView() {
        view = photoDetailView
    }
    
    // MARK: - Selectors
    
    @objc func deleteButtonTapped() {
    }
    
    @objc func saveButtonTapped() {
        guard let image = photoDetailView.photoImageView.image else {
            return
        }
        
        let calendarData = CalendarData()
        calendarData.date = photoDetailView.dateLabel.text ?? ""
        calendarData.memo = photoDetailView.memoTextView.text ?? ""

        // 이미지를 Realm 데이터베이스에 저장
        realmManager.save(calendarData: calendarData, image: image)
        
        popViewController()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        if let calendarData = calendarData {
            photoDetailView.memoTextView.text = calendarData.memo
        } else {
            photoDetailView.memoTextView.text = ""
        }
    }

    private func configureDelegate() {
        photoDetailView.delegate = self
    }
    
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
