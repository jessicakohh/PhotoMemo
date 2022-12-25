//
//  CoreDataManager.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit
import CoreData

// MARK: - Diary 관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName: String = "Diary"
    
    // MARK: - Read
    
    func getDiaryListFromCoreData() -> [Diary] {
        var diaryList: [Diary] = []
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                if let fetchedDiaryList = try context.fetch(request) as? [Diary] {
                    diaryList = fetchedDiaryList
                }
            } catch {
                print("가져오는 것 실패")
            }
        }
        return diaryList
    }
    
    // MARK: - Create
    func saveDiaryData(titleText: String?, memoText: String?, thumbnailImage: Data?, completion: @escaping() -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let diaryData = NSManagedObject(entity: entity, insertInto: context) as? Diary {
                    
                    // MARK: - Diary에 실제 데이터 할당 ⭐️
                    diaryData.titleText = titleText
                    diaryData.date = Date()
                    diaryData.memoText = memoText
                    diaryData.memoImage = thumbnailImage

                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    // MARK: - Delete
    
    func deleteDiary(data: Diary, completion: @escaping() -> Void) {
        guard let date = data.date else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            do {
                if let fetchedDiaryList = try context.fetch(request) as? [Diary] {
                    if let targetDiary = fetchedDiaryList.first {
                        context.delete(targetDiary)
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    // MARK: - Update
    
    func updateDiary(newDiaryData: Diary, completion: @escaping() -> Void) {
        guard let date = newDiaryData.date else {
            completion()
            return
        }
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            do {
                if let fetchedDiaryList = try context.fetch(request) as? [Diary] {
                    if var targetDiary = fetchedDiaryList.first {
                        
                        // MARK: - Diary에 실제 데이터 재할당 (바꾸기)
                        targetDiary = newDiaryData
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }


}

