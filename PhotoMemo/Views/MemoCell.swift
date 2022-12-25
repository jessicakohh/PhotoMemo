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
    
    
    // diaryData를 전달받을 변수 (전달받으면 -> 표시하는 메서드 실행)
    var diaryData: Diary? {
        didSet {
        }
    }
    
    var updateButtonPressed: (MemoCell) -> Void = { (sender) in }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        
    }
    
    func configureUIwithData() {
        
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
    }
}
