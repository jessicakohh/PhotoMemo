//
//  ResetPasswordView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/25.
//

import UIKit

protocol ResetPasswordViewDelegate: AnyObject {
    func resetButtonTapped(_ resetPasswordView: ResetPasswordView)
}

class ResetPasswordView: UIView {
    
    weak var delegate: ResetPasswordViewDelegate?
    
    // MARK: - Properties
    
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "가입하신 이메일을 입력하세요."
        label.textColor = .mainDarkGrey
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.newGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.layer.borderColor = .none
        return textField
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("비밀번호 리셋하기", for: .normal)
        button.addTarget(self, action: #selector(resetPasswordButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.mainDarkGrey
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkRed
        label.isHidden = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
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
    
    // MARK: - Selectors
    
    @objc func resetPasswordButton() {
        delegate?.resetButtonTapped(self)
    }
    
    
    // MARK: - Helpers
    private func configureUI() {
        backgroundColor = .mainGrey
    }
}


// MARK: - Layouts

extension ResetPasswordView: LayoutProtocol {
    
    func setSubViews() {
        [guideLabel, emailTextFieldView, resultLabel, resetButton].forEach { self.addSubview($0) }

    }
    
    func setLayout() {
        
        guideLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(300)
        }
        
        emailTextFieldView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(guideLabel.snp.bottom).offset(30)
            make.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextFieldView.snp.bottom).offset(15)
        }
        
        resetButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(120)
            make.top.equalTo(emailTextFieldView.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        
    }

}
