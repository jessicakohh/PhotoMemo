//
//  CalendarInfoInstance.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import Foundation

class CalendarInfoInstance {
    
    var title: String = "My Calendar"
    var image: Data?
    var id: String = "id"
    var index: Int
    
    init(title: String, image: Data? = nil, id: String, index: Int) {
        self.title = title
        self.image = image
        self.id = id
        self.index = index
    }
    
    init(image: Data, index: Int) {
        self.image = image
        self.index = index
    }
}
