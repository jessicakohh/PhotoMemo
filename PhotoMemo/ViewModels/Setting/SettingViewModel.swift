//
//  TableViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit

class SettingViewModel {
    
    // MARK: - Properties
    
    var items: [String] = []
    
    var userModel: UserModel?
    

    
    // MARK: - Helpers

    
    func fetchUser(completion: @escaping (UserModel?) -> Void) {
        UserService.shared.fetchUser { userModel in
            self.userModel = userModel
            completion(userModel)
        }
    }
    
    func downloadProfileImage(completion: @escaping (UIImage?) -> Void) {
        if let imageUrlString = self.userModel?.profileImageUrl {
            UserService.shared.downloadImage(from: imageUrlString) { image in
                completion(image)
            }
        } else {
            completion(nil)
        }
    }
    
    func fetchItems() {
        // 데이터 가져오기
        items = ["위치정보 이용약관", "개인정보 처리방침", "외부 라이브러리"]
    }
}
