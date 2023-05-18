//
//  HalfModalViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/05/17.
//

import UIKit

final class HalfModalViewController: UIViewController {
    
    // MARK: - Properties
    var halfModalView = HalfModelView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
        configureUI()
        
    }
    
    override func loadView() {
        view = halfModalView
        
    }
    
    
    
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {

    }
    
    private func configureDelegate() {
        
    }
    
    func presentHalfModal() {
        // 모달을 표시하기 전에 추가적인 설정이 필요하다면 여기에 작성합니다.
        
        // 모달 애니메이션과 함께 모달을 표시합니다.
        halfModalView.transform = CGAffineTransform(translationX: 0, y: halfModalView.bounds.height)
        UIView.animate(withDuration: 0.3) {
            self.halfModalView.transform = CGAffineTransform.identity
        }
    }

}
    
    // MARK: - Layout Extension

