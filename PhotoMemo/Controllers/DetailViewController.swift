//
//  DetailViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var openImageButton: UIButton!
    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var memoView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var imagePicker = UIImagePickerController()
    let diaryManager = CoreDataManager.shared
    
    var diaryData: Diary? {
        didSet {
            print("여기 수정")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUp() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureUI() {
        imageView.layer.cornerRadius = imageView.frame.height / 2

        // 기존 데이터가 있을 때
        if let diaryData = self.diaryData {
            guard let text = diaryData.memoText, let image = diaryData.memoImage else { return }
            titleView.text = text
            memoView.text = text
            //   thumbnailImage.image = UIImage(data: (diaryData?.memoImage)!)
            imageView.image = UIImage(data: image)
            
            // 기존 데이터가 없을 때
        } else {
            
        }
    }

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pickImageButton(_ sender: UIButton) {
        openImagePicker()
    }
    
    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        var sharedObject = [Any]()
        sharedObject.append(imageView)
        let vc = UIActivityViewController(activityItems: sharedObject, applicationActivities: nil)
        vc.popoverPresentationController?.permittedArrowDirections = []
        vc.popoverPresentationController?.sourceView = self.view
        self.present(vc, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        // 기존 데이터가 있을 때 -> 기존 데이터 업데이트
        if let diaryData = self.diaryData {
            // 텍스트뷰에 저장되어있는 메시지
            diaryData.titleText = titleView.text
            diaryData.memoText = memoView.text
            imageView.image = UIImage(data: (diaryData.memoImage)!)
            
            // 기존 데이터가 없을 때 -> 새로운 데이터 생성
        } else {
            let titleText = titleView.text
            let memoText = memoView.text
            let thumbnailImage = imageView.image
            // if let imageData = UIImagePNGRepresentation(image.pngData()) {
//            diaryManager.saveDiaryData(titleText: titleText, memoText: memoText, thumbnailImage: thumbnailImage) {
                print("저장완료")
                // 다시 전화면으로 돌아가기
                self.navigationController?.popViewController(animated: true)
            }
        }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
    
    }
    

// MARK: - 이미지

extension DetailViewController: UIImagePickerControllerDelegate {
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let img = info[.originalImage] as? UIImage {
            self.imageView.image = img
        }
    }
}

// MARK: - 뒤로가기 제스처
extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

