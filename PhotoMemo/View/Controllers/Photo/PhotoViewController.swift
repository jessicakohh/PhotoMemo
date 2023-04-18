//
//  PhotoViewControllers.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/13.
//

import UIKit
import SnapKit


final class PhotoViewController: UIViewController {
    
    // MARK: - Properties
    var photoView = PhotoView()

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func loadView() {
        view = photoView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
}
    
    // MARK: - Layout Extension

    
    

