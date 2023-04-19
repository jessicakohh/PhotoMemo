//
//  PhotoViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

// 데이터 모델
struct Item {
    let title: String
    let imageURL: URL
}

// 뷰 모델
class PhotoViewModel {
    var items: [Item] = []
    
    func fetchData() {
        // 데이터 모델에서 데이터를 가져와 items 배열에 저장하는 로직
    }
    
}
