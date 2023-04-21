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
    
    // MARK: - Helpers
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .mainDarkGrey
    }
    
    private func configureUI() {
        if let imageData = calendarData?.image {
            photoDetailView.photoImageView.image = UIImage(data: imageData)
        }
    }
    
    
}


