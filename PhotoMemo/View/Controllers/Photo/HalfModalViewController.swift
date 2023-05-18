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
        halfModalView.delegate = self
    }


}
    
    // MARK: - Layout Extension

extension HalfModalViewController: HalfModelViewDelegate {
    
    func webImageButtonTapped(_ halfModalView: HalfModelView) {
        print("웹 이미지 찾기 버튼")
    }
    
    func albumImageButtonTapped(_ halfModalView: HalfModelView) {
        print("앨범 버튼")
    }
    
    func photoImageButtonTapped(_ halfModalView: HalfModelView) {
        print("사진찍기 버튼")
    }
 
}
