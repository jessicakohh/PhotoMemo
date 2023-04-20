//
//  RalmManager.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/20.
//

import UIKit
import RealmSwift

final class RealmManager {
    
    let realm = try! Realm()
    
    static let shared = RealmManager()
    var calendarList = [CalendarData]()
    
    // MARK: -  Create
    
    func save(calendarData: CalendarData, image: UIImage) {
        let newData = CalendarData()
        newData.id = UUID().uuidString
        newData.date = calendarData.date
        newData.weather = calendarData.weather
        newData.weatherImage = image.jpegData(compressionQuality: 0.5)
        newData.image = image.jpegData(compressionQuality: 0.5)
        newData.memo = calendarData.memo
        
        try! realm.write {
            realm.add(newData)
        }
    }
    
    func getData(withId id: String) -> CalendarData? {
        let existingData = realm.objects(CalendarData.self).filter { $0.id == id }.first
        return existingData
    }
    
    
    // MARK: - Read
    
    func fetchAll() -> Results<CalendarData> {
        let results = realm.objects(CalendarData.self)
        return results
    }
    
    func fetch(byDate date: String) -> CalendarData? {
        let predicate = NSPredicate(format: "date == %@", date)
        let results = realm.objects(CalendarData.self).filter(predicate)
        return results.first
    }
    
    // MARK: - Update
    
    func update(calendarData: CalendarData, image: UIImage) {
        guard let existingData = getData(withId: calendarData.id) else {
            return
        }
        do {
            try realm.write {
                existingData.date = calendarData.date
                existingData.weather = calendarData.weather
                existingData.weatherImage = image.jpegData(compressionQuality: 0.5)
                existingData.image = image.jpegData(compressionQuality: 0.5)
                existingData.memo = calendarData.memo
            }
        } catch {
            print("Error updated calendarData: \(error)")
        }
    }
    
    // MARK: - Delete

    func deleted(calendarData: CalendarData) {
        do {
            try realm.write {
                realm.delete(calendarData)
            }
        } catch {
            print("Error deleting calendarData: \(error)")
        }
    }


    
    
}
