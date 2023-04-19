//
//  TableViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

class SettingViewModel {
    
    var items: [String] = []
    
    func fetchItems() {
        // 데이터 가져오기
        items = ["위치정보 이용약관", "개인정보 처리방침", "외부 라이브러리"]
    }
}
