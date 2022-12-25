//
//  Diary+CoreDataProperties.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//
//

import Foundation
import CoreData


extension Diary {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var memoImage: Data?
    @NSManaged public var memoText: String?
    @NSManaged public var titleText: String?
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension Diary : Identifiable {

}
