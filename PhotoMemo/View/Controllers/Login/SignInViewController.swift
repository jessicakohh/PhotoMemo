//
//  SignViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    private let signInView = SignInView()
//    private let viewModel = LoginViewModel()
        
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
      view = signInView
  }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    
    // MARK: - Layout Extension
}
