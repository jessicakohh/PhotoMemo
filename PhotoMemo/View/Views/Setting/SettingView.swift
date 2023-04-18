//
//  SettingView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit
import SnapKit

class SettingView: UIView {
    
    // MARK: - Properties
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .newGrey
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 180 / 2
        return imageView
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        // 버튼 이미지 넣기
        return button
    }()
    
    private lazy var plusIcon: UIImageView = {
        let image = UIImage(named: "square.and.pencil.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .mainDarkGrey
        imageView.backgroundColor = .none
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "닉네임"
        textField.tintColor = .mainDarkGrey
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.newGrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = .none
        return button
    }()
    
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.newGrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = .none
        return button
    }()
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoutButton, signOutButton])
        stackView.axis = .horizontal
        stackView.spacing = 50
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
        backgroundColor = .white
    }
}

extension SettingView: LayoutProtocol {
    
    func setSubViews() {
        self.addSubview(profileImage)
        self.addSubview(profileButton)
        self.addSubview(plusIcon)
        self.addSubview(nameTextField)
        self.addSubview(tableView)
        self.addSubview(dateStackView)
    }
    
    func setLayout() {
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
        
        profileButton.snp.makeConstraints { make in
            make.centerX.equalTo(profileImage.snp.centerX)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.width.equalTo(profileImage.snp.width)
            make.height.equalTo(profileImage.snp.height)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(profileImage.snp.centerX)
            make.top.equalTo(profileImage.snp.bottom).offset(8)
        }
        
        plusIcon.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(-15)
            make.width.height.equalTo(25)
            make.trailing.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(40)
            make.height.lessThanOrEqualTo(300)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        profileImage.layer.zPosition = CGFloat(-1)
    }
    
    
}