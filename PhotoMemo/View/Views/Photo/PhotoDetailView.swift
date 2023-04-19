//
//  PhotoDetailView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/19.
//

import UIKit

final class PhotoDetailView: UIView {
    // MARK: - Properties
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers

}

extension PhotoDetailView: LayoutProtocol {
    
    func setSubViews() {
    }
    
    func setLayout() {
    }
    
    
}

