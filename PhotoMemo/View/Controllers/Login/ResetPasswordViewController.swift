//
//  ResetViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    private let resetPasswordView = ResetPasswordView()
//    private let viewModel = LoginViewModel()
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
      view = resetPasswordView
  }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    
    // MARK: - Layout Extension
}
