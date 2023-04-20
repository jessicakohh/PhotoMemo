//
//  PhotoDetailView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/19.
//

import UIKit

final class PhotoDetailView: UIView {
    // MARK: - Properties
    
    let imagePicker = UIImagePickerController()

    
    lazy var yearLabel: UILabel = {
       let dateLabel = UILabel()
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy"
        let today = myFormatter.string(from: Date())
        dateLabel.text = today
        dateLabel.textAlignment = .left
        dateLabel.textColor = .darkGray
        dateLabel.font = UIFont.systemFont(ofSize: 32, weight: .black)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.5 // 최소 스케일링 비율
        dateLabel.numberOfLines = 0 // 필요한 만큼 행 수를 표시하도록 설정
        dateLabel.sizeToFit() // 레이블의 크기를 내용에 맞게 자동 조정
        return dateLabel
    }()
    
    lazy var dateLabel: UILabel = {
       let dateLabel = UILabel()
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM월 dd일"
        let today = myFormatter.string(from: Date())
        dateLabel.text = today
        dateLabel.textAlignment = .left
        dateLabel.textColor = .darkGray
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        return dateLabel
    }()
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearLabel, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
 
// ----------- ☀️ 날씨
    lazy var locationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "locationButton"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }()
    
    lazy var weatherLabel: UILabel = {
       let label = UILabel()
        label.text = "오늘 날씨"
        label.textAlignment = .left
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .black)
        return label
    }()
    
    lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationButton, weatherLabel])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var weatherImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "weatherImageView")
        return imageView
    }()
    
    lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
         return imageView
    }()
    

// ----------- 📷 하단
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "addPhotoImage")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var memoLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "memoImageView")
        return imageView
    }()
    
    lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.boldSystemFont(ofSize: textView.font?.pointSize ?? UIFont.systemFontSize)
        textView.textColor = .darkGray
        return textView
    }()

    lazy var memoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "memoTextView")
        return imageView
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
        self.backgroundColor = .mainGrey
    }
}

extension PhotoDetailView: LayoutProtocol {
    
    func setSubViews() {
        [dateStackView, weatherStackView, weatherImageView, weatherIcon, photoImageView, addPhotoButton, memoLabel, memoTextView, memoImageView]
            .forEach { self.addSubview($0) }    }
    
    func setLayout() {
        dateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(dateStackView.snp.trailing).offset(10)
            make.trailing.equalTo(weatherImageView.snp.leading).offset(-10)
            make.centerY.equalTo(dateStackView.snp.centerY)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.width.height.equalTo(43)
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalTo(weatherStackView.snp.centerY)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.centerX.equalTo(weatherImageView.snp.centerX)
            make.centerY.equalTo(weatherImageView.snp.centerY)
            make.width.equalTo(weatherImageView.snp.width)
            make.height.equalTo(weatherImageView.snp.height)
        }
        
        // ----------- 📷 하단
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateStackView.snp.bottom).offset(10)
            make.width.height.equalTo(350)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(photoImageView.snp.centerX)
            make.centerY.equalTo(photoImageView.snp.centerY)
            make.width.equalTo(photoImageView.snp.width)
            make.height.equalTo(photoImageView.snp.height)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(28)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.centerX.equalTo(memoImageView.snp.centerX)
            make.centerY.equalTo(memoImageView.snp.centerY)
            make.width.equalTo(315)
        }
        
        memoImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(150)
            make.top.equalTo(memoLabel.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        memoImageView.layer.zPosition = CGFloat(-1)
    }
    
}

