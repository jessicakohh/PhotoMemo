<img width="100" alt="1" src="https://user-images.githubusercontent.com/108605997/214176123-728f9b9a-2dbb-41c7-8692-0919e63e046f.png"> 


# PhotoMemo  

간단한 하루를 기록해보세요.  
사진과 함께 오늘의 추억을 기록할 수 있어요.  
오늘의 추억을 친구들과 공유해보세요 🗒  

- 간단한 일기를 사진과 함께 저장할 수 있습니다.  
- 일기를 공유할 수 있습니다.  

[![포토메모](https://user-images.githubusercontent.com/108605997/214177110-4e5b4891-a038-436c-99a9-19c8e7c10056.png)](https://apps.apple.com/kr/app/photomemo-%ED%8F%AC%ED%86%A0%EB%A9%94%EB%AA%A8/id1661616427)

## 프로젝트 
앱스토어에 수많은 메모앱이 있고, 실제로 많은 앱들을 사용해보았지만 사진과 메모를 함께 간단하게 저장하기에는 불편함이 있었습니다. 그래서 내가 불편했던 점들을 개선하고 필요한 부분을 가지고, 직접 만들어서 사용해보고자 사진과 메모가 날짜별로 저장될 수 있는 메모앱을 개발하였습니다.

- 프로젝트 기간 : 2022.12.12 ~ 12.27
- 앱스토어 출시 : 2023.01.04 ~
- 개인 프로젝트


## 개발 환경
- Swift
- MVC
- UIKit
- SPM

## 라이브러리
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [SideMenu](https://github.com/jonkykong/SideMenu)


## 스크린샷 및 구현기능
|TableView|DetailViewController|Swipe to delete|SideMenu|
|---|---|---|---|
|<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174160-39400dd0-7abc-45bf-9dbd-0d6897286e4b.gif">| <img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174610-51fdfdac-dbd6-4844-b45d-bd7f8ad7a3d6.gif"> |<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174712-073ad04c-d3ca-4b42-ba88-3ef5a07229d8.gif"> |<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174771-f94b3760-b6b3-4c2a-a077-64962d1289f6.gif"> |

|기능|구현|
|---|---|
|테이블 뷰|✔️|
|사진 추가, 변경, 삭제, 공유|✔️|
|메모 추가, 변경, 삭제, 공유|✔️|
|메모 날짜별 내림차순 정렬|✔️|
|코어데이터 저장|✔️|

**TableView**

- 메인 화면에는 저장된 일기의 목록이 보여지도록 구성했습니다.
- 메모를 추가하게 되면, 가장 최근에 추가 된 메모가 TableView의 제일 첫번째로 오게 했습니다.

<details>
<summary>코드</summary>
<div markdown="1">        

```swift  
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
```  
    
</div>
</details>
        
- 스와이프하여 메모를 삭제할 수 있습니다.
<details>
<summary>코드</summary>
<div markdown="1"> 
    
```swift
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                return .delete
            }
            
            func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                tableView.beginUpdates()
                let subject = self.savedCoreArray[indexPath.row]
                savedCoreArray.remove(at: indexPath.row)
                memoManager.deleteCoreData(targetData: subject) {
                    
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
```
    
</div>
</details>
        
<details>
<summary>CoreData 코드</summary>
<div markdown="1"> 
        
```swift
        import UIKit
        import CoreData
        
        protocol MemoInfoDelegate: AnyObject {
            func getInfo() -> [Int]
        }
        
        final class MemoManager {
            private let coreDataManager = CoreDataManager.shared
            static let shared = MemoManager()
            var coreDataArray: [Diary] = []
            var delegate: MemoInfoDelegate?
            
            private init() {
                coreDataArray = coreDataManager.getDiaryListFromCoreData()
                print(coreDataArray)
            }
            
            func getCoreDataArray() -> [Diary] {
                print(#function)
                return coreDataArray
            }
            
            func saveCoreData(titleText: String, memoText: String, thumbnailImage: Data, completion: @escaping() -> Void) {
                coreDataManager.saveDiaryData(titleText: titleText, memoText: memoText, thumbnailImage: thumbnailImage) {
                    completion()
                    self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
                }
                print("\(#function) : CoreData Saved")
            }
            
            func updateCoreData(newCoreData: Diary, completion: @escaping() -> Void) {
                coreDataManager.updateDiary(newDiaryData: newCoreData) {
                    completion()
                    self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
                }
                print("\(#function) : CoreData Updated")
            }
            
            func deleteCoreData(targetData: Diary, completion: @escaping() -> Void) {
                coreDataManager.deleteDiary(data: targetData) {
                    completion()
                    self.coreDataArray = self.coreDataManager.getDiaryListFromCoreData()
                }
                print("\(#function) : CoreData Deleted")
            }
            
        }
```
</div>
</details>
    

**CoreData**

- CoreData를 사용해 데이터베이스 CRUD를 구현하였습니다.
- [이미지 코어 데이터 저장 참고](notion://www.notion.so/jesskoh/%5B%3Chttps://developer-p.tistory.com/148%3E%5D(%3Chttps://developer-p.tistory.com/148%3E))

**사진 권한** 

- [사진첩 권한 허용 참고](https://gonslab.tistory.com/28](https://gonslab.tistory.com/28)
- 상세 페이지(DetailViewContoller)에서 사진 및 메모의 수정, 삭제가 가능합니다.

**SideMenu** 

- 앱의 버전, 개발자에게 이메일 전송 등 자잘한 기능을 사용자가 선택할때만 볼 수 있게끔 하는 것이 깔끔하다고 생각되어 사용하였습니다.

**IQKeyboardManagerSwift**

- 메모 작성 시, 키보드가 화면을 가리는 경우가 생겨 화면 임의의 곳을 터치하면 dismiss keyboard가 실행 될 수 있도록 하였습니다.




## 배운점 및 고민
1. **다양한 iOS 프레임워크에 익숙해졌습니다.**
    - 레이블, 버튼, 이미지뷰, 텍스트필드, 텍스트뷰, 스택뷰, 얼럿
    - 네비게이션바, 탭비, 서치바, 피커뷰
    - 화면 이동과 데이터 전달 (segue)
    - **CoreData**
        - CoreData를 이용해 데이터베이스 CRUD 구현
    - **테이블 뷰**
        - 테이블뷰에서의 화면 이동
        - 테이블뷰의 델리게이트 패턴과 이론적인 내용 (셀의 재사용, 델리게이트 메서드)
2. **디자인 패턴에 대한 이해도를 높일 수 있었습니다.**
    - 델리게이트 패턴의 구조에 대한 정확한 이해
        - 커스텀 델리게이트 패턴의 사용
    - 싱글톤 패턴
    - MVC 패턴의 이해


## 심사과정
- 리젝 사유
    
    **Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage**
    
    - 사진이 어느 용도에 사용되는지 더 자세하게 예시를 들어 작성하라는 내용의 리젝이었습니다.
    - 메시지를
    `앨범 접근을 위해 권한이 필요합니다` → <br/>
    `메모의 사진 업로드를 위해 사진첩에 액세스하고 싶습니다. 귀하의 사진은 귀하의 허락없이 공유되지 않습니다.` <br/>
    로 변경하여 심사를 다시 넣은 후, 통과되었습니다.

## 업데이트 과정
Ver. 1
 - 1.0 : App Store Release (2023.01.04)
 - 1.0.2 (2023.01.13)
    - 기존 사진 삭제 시 수정 여부 선택할 수 있도록 변경
    - 메모를 스와이프하여 삭제 가능하게 변경
