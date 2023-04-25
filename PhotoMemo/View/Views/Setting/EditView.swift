//
//  EditVuew.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/24.
//

import UIKit

class EditView: UIView {
    
    // MARK: - Properties
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .newGrey
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 150 / 2
        return imageView
    }()
    
    private lazy var plusIconImageView: UIImageView = {
        let image = UIImage(named: "profileAddButton")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .mainDarkGrey
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .none
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imagePickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        return button
    }()
    
    private lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .mainDarkGrey
        return label
    }()
    
    private lazy var nameTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.newGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = .none
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        return textField
    }()
    
    lazy var modifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainDarkGrey
        button.setTitle("수정하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        return button
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
        backgroundColor = .mainGrey
    }

}


// MARK: - Layouts

extension EditView: LayoutProtocol {
    func setSubViews() {
        [profileImage, plusIconImageView, imagePickerButton, nameTitleLabel, nameTextFieldView, nameTextField, modifyButton].forEach { self.addSubview($0) }
    }
    
    func setLayout() {
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.height.equalTo(150)
        }
        
        plusIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.right.equalTo(profileImage.snp.right).inset(7)
            make.bottom.equalTo(profileImage.snp.bottom).inset(7)
            make.top.equalTo(profileImage.snp.top).inset(113)
        }
        
        imagePickerButton.snp.makeConstraints { make in
            make.centerX.equalTo(profileImage.snp.centerX)
            make.centerY.equalTo(profileImage.snp.centerY)
            make.width.equalTo(profileImage.snp.width)
            make.height.equalTo(profileImage.snp.height)
        }
        
        nameTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(70)
            make.width.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        nameTextFieldView.snp.makeConstraints { make in
            make.left.equalTo(nameTitleLabel.snp.right).offset(0)
            make.right.equalToSuperview().inset(70)
            make.centerY.equalToSuperview()
            make.height.equalTo(35)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextFieldView.snp.top)
            make.bottom.equalTo(nameTextFieldView.snp.bottom)
            make.width.equalTo(nameTextFieldView.snp.width).inset(12)
            make.centerX.equalTo(nameTextFieldView.snp.centerX)
        }

        modifyButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextFieldView.snp.centerY).offset(50)
            make.left.right.equalToSuperview().inset(150)
            make.height.equalTo(35)
        }
    }

}
