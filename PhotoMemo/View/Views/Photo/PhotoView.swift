//
//  PhotoView.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit
import SnapKit

protocol PhotoViewDelegate: AnyObject {
    func photoViewDidTapPreviousButton(_ photoView: PhotoView)
    func photoViewDidTapNextButton(_ photoView: PhotoView)
}

class PhotoView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: PhotoViewDelegate?
    
    private let previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previousButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        return button
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy.MM"
        let thisMonth = myFormatter.string(from: Date())
        label.text = thisMonth
        label.textAlignment = .center
        label.textColor = .mainDarkGrey
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton, monthLabel, nextButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    lazy var rectangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rectangleView")
        return imageView
    }()
    
    lazy var labelsStackView: UIStackView = {
        let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
        var labels: [UILabel] = []

        for day in daysOfWeek {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.textColor = .white
            label.font =  UIFont.systemFont(ofSize: 13, weight: .bold)
            labels.append(label)
            self.addSubview(label)
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    
    
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc private func didTapPreviousButton() {
        delegate?.photoViewDidTapPreviousButton(self)
    }
    
    @objc private func didTapNextButton() {
        delegate?.photoViewDidTapNextButton(self)
    }

    
    
    // MARK: - Helpers
    
}


// MARK: - Layouts

extension PhotoView: LayoutProtocol {
    func setSubViews() {
        self.addSubview(dateStackView)
        self.addSubview(rectangleImageView)
        self.addSubview(labelsStackView)
    }
    
    func setLayout() {
        dateStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)

        }
        
        rectangleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.centerX.equalTo(rectangleImageView.snp.centerX)
            make.centerY.equalTo(rectangleImageView.snp.centerY)
            make.width.equalTo(rectangleImageView.snp.width)
            make.height.equalTo(rectangleImageView.snp.height)
        }
        
    }
}

