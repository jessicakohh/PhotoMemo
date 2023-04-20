//
//  PhotoViewModel.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/18.
//

import UIKit
import RealmSwift

final class PhotoViewModel {
    
    static let realmManager = RealmManager.shared
    
    // Realm에서 가져온 PhotoData 객체의 리스트를 저장하는 변수
    // Results는 Realm에서 제공하는 객체로, 데이터베이스에서 쿼리한 결과를 동적으로 업데이트하는 리스트 형태로 변환
    var calendars: Results<CalendarData>?
    
    // ViewModel을 생성할 때 필요한 초기화
//    init() {
//        self.calendars = CalendarData.realmManager.fetchAll()
//    }
    
    // 셀의 갯수 반환
    func numberOfItems() -> Int {
        return calendars?.count ?? 0
    }
    
    // View에서 셀을 생성할 때, 해당 셀에 표시할 데이터를 제공하는 메소드로 사용
    func calendarData(at indexPath: IndexPath) -> CalendarData? {
        return calendars?[indexPath.row]
    }
    
}
