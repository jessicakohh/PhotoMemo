<img width="100" alt="1" src="https://user-images.githubusercontent.com/108605997/214176123-728f9b9a-2dbb-41c7-8692-0919e63e046f.png"> 


# PhotoMemo  

간단한 하루를 기록해보세요.  
사진과 함께 오늘의 추억을 기록할 수 있어요.  
오늘의 추억을 친구들과 공유해보세요 🗒  

- 간단한 일기를 사진과 함께 저장할 수 있습니다.  
- 일기를 공유할 수 있습니다.  

[![포토메모](https://user-images.githubusercontent.com/108605997/214177110-4e5b4891-a038-436c-99a9-19c8e7c10056.png)](https://apps.apple.com/kr/app/photomemo-%ED%8F%AC%ED%86%A0%EB%A9%94%EB%AA%A8/id1661616427)

## 프로젝트 
앱스토어에 수많은 메모 어플이 있고, 실제 사용해보았지만 사진 위주로 메모를 간단하게 기록할 수 있는 어플이 없었습니다. <br/>
내가 불편했던 점들을 개선하고, 필요한 부분만을 직접 만들어서 사용해보고자 개발한 개인 프로젝트입니다. 

- 프로젝트 기간 : 2022.12.12 ~ 12.27
- 앱스토어 출시 : 2023.01.04 ~
- 개인 프로젝트

## 스크린샷
|TableView|DetailViewController|Swipe to delete|SideMenu|
|---|---|---|---|
|<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174160-39400dd0-7abc-45bf-9dbd-0d6897286e4b.gif">| <img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174610-51fdfdac-dbd6-4844-b45d-bd7f8ad7a3d6.gif"> |<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174712-073ad04c-d3ca-4b42-ba88-3ef5a07229d8.gif"> |<img width="196" alt="1" src="https://user-images.githubusercontent.com/108605997/214174771-f94b3760-b6b3-4c2a-a077-64962d1289f6.gif"> |

1. NavigationBar에서 Add Photo Button (+) 을 누르면 사진과 메모를 기록할 수 있는 페이지가 나옵니다.  
    - [사진첩 권한 허용 참고]([https://gonslab.tistory.com/28](https://gonslab.tistory.com/28))
2. 사진과 메모는 TableView 형식으로 코어데이터에 저장됩니다.
    - [이미지 코어 데이터 저장 참고]([https://developer-p.tistory.com/148](https://developer-p.tistory.com/148))
3. 상세 페이지(DetailViewContoller)에서 사진 및 메모의 수정, 삭제가 가능합니다.
4. TableView에서 스와이프하여 메모를 삭제할 수 있습니다.


## 개발 환경
- Swift
- MVC
- UIKit
- SPM

## 라이브러리
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [SideMenu](https://github.com/jonkykong/SideMenu)

## 구현기능
|기능|구현|
|---|---|
|테이블 뷰|✔️|
|사진 추가, 변경, 삭제, 공유|✔️|
|메모 추가, 변경, 삭제, 공유|✔️|
|메모 날짜별 내림차순 정렬|✔️|
|코어데이터 저장|✔️|


## 배운점 및 고민
**1. 다양한 iOS 프레임워크에 익숙해졌습니다.**  
&nbsp;&nbsp;- 레이블, 버튼, 이미지뷰, 텍스트필드, 텍스트뷰, 스택뷰, 얼럿  
&nbsp;&nbsp;- 네비게이션바, 탭비, 서치바, 피커뷰  
&nbsp;&nbsp;- 화면 이동과 데이터 전달 (segue)  
&nbsp;&nbsp;- **CoreData**  
&nbsp;&nbsp;&nbsp;&nbsp;  - CoreData를 이용해 데이터베이스 CRUD 구현  
&nbsp;&nbsp;- **테이블 뷰**  
&nbsp;&nbsp;&nbsp;&nbsp;  - 테이블뷰에서의 화면 이동  
&nbsp;&nbsp;&nbsp;&nbsp;  - 테이블뷰의 델리게이트 패턴과 이론적인 내용 (셀의 재사용, 델리게이트 메서드)   
         <br/>
**2. 디자인 패턴에 대한 이해도를 높일 수 있었습니다.**  
&nbsp;&nbsp;- 델리게이트 패턴의 구조에 대한 정확한 이해  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  - 커스텀 델리게이트 패턴의 사용  
&nbsp;&nbsp;- 싱글톤 패턴  
&nbsp;&nbsp;- MVC 패턴의 이해  

## Structure


## 심사과정
- 리젝 사유
    
    **Guideline 5.1.1 - Legal - Privacy - Data Collection and Storage**
    
    - 사진이 어느 용도에 사용되는지 더 자세하게 예시를 들어 작성하라는 내용의 리젝이었습니다.
    - 메시지를
    `앨범 접근을 위해 권한이 필요합니다` → 
    `메모의 사진 업로드를 위해 사진첩에 액세스하고 싶습니다. 귀하의 사진은 귀하의 허락없이 공유되지 않습니다.` 
    로 변경하여 심사를 다시 넣은 후, 통과되었습니다.

## 업데이트 과정
Ver. 1
 - 1.0 : App Store Release (2023.01.04)
 - 1.0.2 (2023.01.13)
    - 기존 사진 삭제 시 수정 여부 선택할 수 있도록 변경
    - 메모를 스와이프하여 삭제 가능하게 변경
