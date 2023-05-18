//
//  HalfModelView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/05/17.
//

import UIKit

final class HalfModelView: UIView {
    
    // MARK: - Properties
    
    lazy var webImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "webImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    
    lazy var webImageLabel: UILabel = {
        let label = UILabel()
        label.text = "웹 이미지"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var webStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [webImageButton, webImageLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var albumImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "albumImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var albumLabel: UILabel = {
        let label = UILabel()
        label.text = "앨범사진"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    lazy var albumStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [albumImageButton, albumLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var photoImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "photoImage")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 촬영"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    
    lazy var photoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImageButton, photoLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var halfViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [webStackView, albumStackView, photoStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    

    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        setSubViews()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .newGrey
        
    }
} 


// MARK: - Layouts

extension HalfModelView: LayoutProtocol {
    
    func setSubViews() {
        self.addSubview(halfViewStackView)
    }
    
    func setLayout() {
        halfViewStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
}
