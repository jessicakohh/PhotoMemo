////
////  DetailViewController.swift
////  PhotoMemo
////
////  Created by juyeong koh on 2022/12/25.
////
//
//import UIKit
//import PhotosUI
//
//class DetailViewController: UIViewController, UINavigationControllerDelegate {
//    
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var openImageButton: UIButton!
//    @IBOutlet weak var titleView: UITextView!
//    @IBOutlet weak var memoView: UITextView!
//    @IBOutlet weak var saveButton: UIBarButtonItem!
//    
//    var imagePicker = UIImagePickerController()
//    let diaryManager = CoreDataManager.shared
//    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
//    
//    var diaryData: Diary? {
//        didSet {
//            print("여기 수정")
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUp()
//        configureUI()
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//    
//    func setUp() {
//        titleView.delegate = self
//        memoView.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        
//        PHPhotoLibrary.requestAuthorization { (state) in
//            print(state)
//        }
//        
//    }
//    
//    func configureUI() {
//
//        imageView.layer.cornerRadius = imageView.frame.height / 2
//        titleView.layer.cornerRadius = 15
//        memoView.layer.cornerRadius = 20
//        
//        titleView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        memoView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        
//        // 기존 데이터가 있을 때
//        if let diaryData = self.diaryData {
//            guard let text = diaryData.titleText else { return }
//            titleView.text = text
//            guard let text = diaryData.memoText else { return }
//            memoView.text = text
//            guard let image = diaryData.memoImage else { return }
//            imageView.image = UIImage(data: image)
//            
//            // 기존 데이터가 없을 때
//        } else {
//            titleView.text = "제목을 입력해주세요."
//            titleView.textColor = UIColor.lightGray
//            memoView.text = "메모를 입력해주세요."
//            memoView.textColor = UIColor.lightGray
//        }
//    }
//    
//    func showAuthDeniedAlert() {
//        let alert = UIAlertController(title: "앨범 접근 권한을 활성화 해주세요.", message: nil, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "닫기", style: .default, handler: { action in
//            guard let url = URL(string: UIApplication.openSettingsURLString) else {
//                return
//            }
//            if UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    
//    func checkPermission() {
//        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited {
//            DispatchQueue.main.async {
//                self.openImagePicker()
//            }
//        } else if PHPhotoLibrary.authorizationStatus() == .denied {
//            DispatchQueue.main.async {
//                self.showAuthDeniedAlert()
//            }
//        } else if PHPhotoLibrary.authorizationStatus() == .notDetermined {
//            PHPhotoLibrary.requestAuthorization { status in
//                self.checkPermission()
//            }
//        }
//    }
//    
//                                    
//    // MARK: - 뒤로가기
//    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    // MARK: - 사진 버튼
//    @IBAction func pickImageButton(_ sender: UIButton) {
//        if imageView.image != nil {
//            let alert = UIAlertController(title: "사진을 수정하시겠습니까?", message: nil, preferredStyle: .alert)
//            let confirm = UIAlertAction(title: "취소", style: .default, handler: nil)
//            let close = UIAlertAction(title: "수정", style: .default) { [self] UIAlertAction in
//                openImagePicker()
//            }
//            alert.addAction(confirm)
//            alert.addAction(close)
//            present(alert, animated: true, completion: nil)
//        } else {
//            checkPermission()
//        }
//        openImagePicker()
//    }
//    
//    // MARK: - 공유 버튼
//    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
//        var shareItems = [Any]()
//        if let image = self.imageView.image {
//            shareItems.append(image)
//        }
//        if let text = self.titleView.text {
//            shareItems.append(text)
//        }
//        if let text = self.memoView.text {
//            shareItems.append(text)
//        }
//        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
//    }
//    
//    // MARK: - 저장 버튼
//    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
//        // 기존 데이터가 있을 때 -> 기존 데이터 업데이트
//        if let diaryData = self.diaryData {
//            // 텍스트뷰에 저장되어있는 메시지
//            diaryData.titleText = titleView.text
//            diaryData.memoText = memoView.text
//            diaryData.memoImage = self.imageView.image?.jpegData(compressionQuality: 1.0)
//            
//            diaryManager.updateDiary(newDiaryData: diaryData) {
//                print("업데이트 완료")
//                self.navigationController?.popViewController(animated: true)
//            }
//            // 기존 데이터가 없을 때 -> 새로운 데이터 생성
//        } else {
//            let titleText = titleView.text
//            let memoText = memoView.text
//            let memoImage = self.imageView.image?.jpegData(compressionQuality: 1.0)
//            diaryManager.saveDiaryData(titleText: titleText, memoText: memoText, thumbnailImage: memoImage) {
//                print("저장완료")
//                // 다시 전화면으로 돌아가기
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }
//    
//    // MARK: - 삭제 버튼
//    @IBAction func deleteButtonTapped(_ sender: Any) {
//        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: .alert)
//        let confirm = UIAlertAction(title: "취소", style: .default, handler: nil)
//        let close = UIAlertAction(title: "삭제", style: .destructive) { [self] UIAlertAction in
//            self.diaryData?.titleText = titleView.text
//            self.diaryData?.memoText = memoView.text
//            self.diaryData?.memoImage = self.imageView.image?.jpegData(compressionQuality: 1.0)
//            if diaryData?.memoImage == nil {
//                diaryManager.deleteDiary(data: diaryData!) {
//                    self.navigationController?.popViewController(animated: true)
//                }
//            } else {
//                diaryManager.deleteDiary(data: diaryData!) {
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
//        alert.addAction(confirm)
//        alert.addAction(close)
//        present(alert, animated: true, completion: nil)
//    }
//}
//    
//
//// MARK: - 이미지 할당
//extension DetailViewController: UIImagePickerControllerDelegate {
//    func openImagePicker() {
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//            imagePicker.delegate = self
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.allowsEditing = false
//            present(imagePicker, animated: true, completion: nil)
//        }
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        dismiss(animated: true, completion: nil)
//        if let img = info[.originalImage] as? UIImage {
//            self.imageView.image = img
//        }
//    }
//}
//
//// MARK: - 뒤로가기 제스처
//extension DetailViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//}
//
//// MARK: - 텍스트 뷰
//
//extension DetailViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if titleView.textColor == UIColor.lightGray {
//            titleView.text = nil
//            titleView.textColor = UIColor.black
//        }
//        if memoView.textColor == UIColor.lightGray {
//            memoView.text = nil
//            memoView.textColor = UIColor.black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if titleView.text.isEmpty {
//            titleView.text = "제목을 입력해주세요."
//            titleView.textColor = UIColor.lightGray
//        }
//        if memoView.text.isEmpty {
//            memoView.text = "메모를 입력해주세요."
//            memoView.textColor = UIColor.lightGray
//        }
//    }
//    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        titleView.resignFirstResponder()
//        titleView.resignFirstResponder()
//        return true
//    }
//}
//
//extension UIView {
//    func convertToImage() -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        if let context = UIGraphicsGetCurrentContext() {
//            layer.render(in: context)
//            return UIGraphicsGetImageFromCurrentImageContext()
//        }
//        return nil
//    }
//}
