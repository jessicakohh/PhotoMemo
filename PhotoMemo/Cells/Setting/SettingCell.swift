//
//  Cells.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit
import SnapKit

final class SettingCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingCell"
    let label = UILabel()
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        configureUI()
        setSubViews()
        setLayout()
    }
    
    // MARK: - Helpers

    func configureUI() {
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .mainDarkGrey
    }
}

// MARK: - Layouts

extension SettingCell: LayoutProtocol {
    
    
    func setSubViews() {
        addSubview(label)
    }
    
    func setLayout() {
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}


