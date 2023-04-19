//
//  CalendarCell.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit
import SnapKit

class CalendarCell: UICollectionViewCell {
    
    // MARK: - Properties

    let dayOfMonth: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .mainGrey
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setSubViews()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSubViews()
        setLayout()
    }
    
    // 재활용 셀 중첩오류 해결법
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        imgView.isHidden = true
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        backgroundColor = .mainGrey
    }

}


extension CalendarCell: LayoutProtocol {
    
    func setSubViews() {
        contentView.addSubview(dayOfMonth)
        contentView.addSubview(imgView)
    }
    
    func setLayout() {
        
        imgView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(38)
            make.height.equalTo(80)
        }
        
        dayOfMonth.snp.makeConstraints { make in
            make.centerX.equalTo(imgView.snp.centerX)
            make.centerY.equalTo(imgView.snp.centerY)
        }
    }
}
