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


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureUI()
    }
    
    override func loadView() {
        view = photoDetailView
    }
    
    // MARK: - Selectors
    
    @objc func deleteButtonTapped() {
        viewModel.didTapDeleteButton()
    }
    
    @objc func saveButtonTapped() {
        viewModel.saveButtonTapped()
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
    
    
}


