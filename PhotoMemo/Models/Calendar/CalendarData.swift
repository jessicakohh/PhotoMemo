//
//  CalendarData.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/20.
//

import Foundation
import RealmSwift

final class CalendarData: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var date = ""
    @objc dynamic var weather = ""
    @objc dynamic var weatherImage: Data? = nil
    @objc dynamic var image: Data? = nil
    @objc dynamic var memo = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
