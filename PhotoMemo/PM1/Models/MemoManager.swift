////
////  DiaryManager.swift
////  PhotoMemo
////
////  Created by juyeong koh on 2023/01/09.
////
//
//import UIKit
//import CoreData
//
//protocol MemoInfoDelegate: AnyObject {
//    func getInfo() -> [Int]
//}
//
//final class MemoManager {
//    private let coreDataManager = CoreDataManager.shared
//    static let shared = MemoManager()
//    var coreDataArray: [Diary] = []
//    var delegate: MemoInfoDelegate?
//    
//    private init() {
//        coreDataArray = coreDataManager.getDiaryListFromCoreData()
//        print(coreDataArray)
//    }
//    
//    func getCoreDataArray() -> [Diary] {
//        print(#function)
//        return coreDataArray
//    }
//    
//    func saveCoreData(titleText: String, memoText: String, thumbnailImage: Data, completion: @escaping() -> Void) {
//        coreDataManager.saveDiaryData(titleText: titleText, memoText: memoText, thumbnailImage: thumbnailImage) {
//            completion()
//            self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
//        }
//        print("\(#function) : CoreData Saved")
//    }
//    
//    func updateCoreData(newCoreData: Diary, completion: @escaping() -> Void) {
//        coreDataManager.updateDiary(newDiaryData: newCoreData) {
//            completion()
//            self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
//        }
//        print("\(#function) : CoreData Updated")
//    }
//    
//    func deleteCoreData(targetData: Diary, completion: @escaping() -> Void) {
//        coreDataManager.deleteDiary(data: targetData) {
//            completion()
//            self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
//        }
//        print("\(#function) : CoreData Deleted")
//    }
//    
//}
