//
//  MemoCellTableViewCell.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit

final class MemoCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var updateButton: UIButton!
    
    // 재활용 셀 중첩오류 해결법
    override func prepareForReuse() {
        thumbnailImage.image = nil
        thumbnailImage.image = UIImage(named: "emptyImage")
    }
    
    // diaryData를 전달받을 변수 (전달받으면 -> 표시하는 메서드 실행)
    var diaryData: Diary? {
        didSet {
        configureUIwithData()
        }
    }
    
    var updateButtonPressed: (MemoCell) -> Void = { (sender) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        thumbnailImage.layer.cornerRadius = thumbnailImage.frame.height / 2
    }
    
    func configureUIwithData() {
        titleTextLabel.text = diaryData?.titleText
        dateTextLabel.text = diaryData?.dateString
        if diaryData?.memoImage == nil {
            thumbnailImage.image = UIImage(named: "emptyImage")
        } else {
            thumbnailImage.image = UIImage(data: (diaryData?.memoImage)!)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        updateButtonPressed(self)
    }
}
