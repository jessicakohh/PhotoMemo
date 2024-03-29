//
//  LoginView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func loginViewDidTapLoginButton(_ loginView: LoginView)
    func registerButtonTapped(_ loginView: LoginView)
    func resetPasswordButtonTapped(_ loginView: LoginView)
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Properties
    
    private lazy var appLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "appLogo")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.newGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
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
    
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.newGrey.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.font = UIFont.boldSystemFont(ofSize: 13)
        textField.layer.borderColor = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var emailPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인 하기", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = .mainDarkGrey
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    lazy var loginCheckedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkRed
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.mainDarkGrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = .none
        button.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("비밀번호 재설정", for: .normal)
        button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.mainDarkGrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = .none
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(20)
        }
        return button
    }()
    
    private lazy var signInStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signInButton, forgotPasswordButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
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
    
    // MARK: - Selectors
    
    @objc func loginButtonTapped() {
        delegate?.loginViewDidTapLoginButton(self)
    }
    
    @objc func registerButtonTapped() {
        delegate?.registerButtonTapped(self)
    }
    
    @objc func resetPasswordButtonTapped() {
        delegate?.resetPasswordButtonTapped(self)
    }
    
    
    // MARK: - Helpers
    
    private func configureUI() {
        self.backgroundColor = .mainGrey
    }

}

// MARK: - Layouts

extension LoginView: LayoutProtocol {
    func setSubViews() {
        [appLogo, emailPasswordStackView, loginButton, loginCheckedLabel, signInStackView]
            .forEach { self.addSubview($0) }
    }
    
    func setLayout() {
        
        appLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        
        emailPasswordStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(70)
            make.top.equalTo(appLogo.snp.bottom).offset(40)
            make.height.equalTo(80)
        }
        
        loginCheckedLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailPasswordStackView.snp.bottom).offset(10)
        }
        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(120)
            make.top.equalTo(loginCheckedLabel.snp.bottom).offset(10)
            make.height.equalTo(37)
        }
        signInStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
        }
    }
}
