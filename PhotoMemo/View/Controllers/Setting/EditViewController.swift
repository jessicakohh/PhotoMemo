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

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func loadView() {
        view = editView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    // MARK: - Layout Extension
}
