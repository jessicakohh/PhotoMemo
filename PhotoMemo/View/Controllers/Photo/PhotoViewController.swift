//
//  PhotoViewControllers.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/13.
//

import UIKit
import SnapKit
import RealmSwift
import FirebaseAuth


final class PhotoViewController: UIViewController, CalendarViewDelegate {
    
    func photoViewDidTapPreviousButton(_ photoView: CalendarView) {
        selectedDate = calendarHelper.previousMonth(date: selectedDate)
        setMonthView()
    }
    
    func photoViewDidTapNextButton(_ photoView: CalendarView) {
        selectedDate = calendarHelper.nextMonth(date: selectedDate)
        setMonthView()
    }
    
    
    // MARK: - Properties
    
    private var photoView = CalendarView()
    private var realmManager = RealmManager()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var selectedDate = Date()
    private var totalDates = [String]()
    private var thumbnails = [String:UIImage]()
    private let calendarHelper = CalendarHelper()
    
    private let picker = UIImagePickerController()
    
    private var currentCalendarIndex: Int = 0
    private var checkIndex = 0
    private var now = ""
    private var yymm = ""
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedDate = Date()
        configureDelegate()
        
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    override func loadView() {
        view = photoView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AuthManager.shared.authenticateUser()
        configureUI()
        configureCollectionView()
        swipeSetting()
        setMonthView()
    }
    
    
    // MARK: - Selectors
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .left {
            var frame = collectionView.frame
            frame.origin.x -= collectionView.frame.width
            UIView.animate(withDuration: 0.4){
                self.collectionView.frame = frame
            }
            selectedDate = calendarHelper.nextMonth(date: selectedDate)
        } else if sender.direction == .right {
            var frame = collectionView.frame
            frame.origin.x += collectionView.frame.width
            UIView.animate(withDuration: 0.4){
                self.collectionView.frame = frame
            }
            selectedDate = calendarHelper.previousMonth(date: selectedDate)
        }
        setMonthView()
    }
    
    // MARK: - Helpers
    
    private func configureDelegate() {
        picker.delegate = self
        photoView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .mainGrey
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        photoView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photoView.rectangleImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let realm = try! Realm()
        let calendarDataArray = Array(realm.objects(CalendarData.self))
        for calendarData in calendarDataArray {
            if let imageData = calendarData.image,
               let image = UIImage(data: imageData) {
                thumbnails[calendarData.date] = image
            }
        }
    }
    
    private func swipeSetting() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    private func setMonthView() {
        totalDates.removeAll()
        let datesInMonth = calendarHelper.numOfDatesInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstDayOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42){
            if count <= startingSpaces || count - startingSpaces > datesInMonth {
                totalDates.append("")
            } else {
                totalDates.append("\(count-startingSpaces)")
            }
            count += 1
        }
        
        photoView.monthLabel.text = calendarHelper.yearString(date: selectedDate) + "." + calendarHelper.monthString(date: selectedDate)
        yymm = calendarHelper.yearString(date: selectedDate) + calendarHelper.monthString(date: selectedDate)
        self.collectionView.reloadData()
    }
    
}


// MARK: - CollectionView

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalDates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        now = yymm + totalDates[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as? CalendarCell else {
            return UICollectionViewCell()
        }
        cell.dayOfMonth.text = totalDates[indexPath.item]
        
        // thumbnails 딕셔너리에서 이미지를 가져와서 표시
        if let image = self.thumbnails[self.now] {
            cell.imgView.image = image
            cell.imgView.isHidden = false
            cell.imgView.layer.cornerRadius = 10
            cell.contentView.bringSubviewToFront(cell.imgView)
        } else {
            cell.imgView.image = nil
            cell.imgView.isHidden = true
        }
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        now = yymm + totalDates[indexPath.item]
        guard totalDates[indexPath.item] != "" else { return }
        
        if thumbnails[now] == nil {
            
            let halfModalViewController = HalfModalViewController()
            present(halfModalViewController, animated: true)
            
        } else {
            checkIndex += 1
            let photoDetailVC = PhotoDetailViewController()
            photoDetailVC.photoDetailView.yearLabel.text = calendarHelper.yearString(date: selectedDate)
            
            let lastTwoCharacters = String(now.suffix(2))
            let lastCharacter = String(now.suffix(1))
            
            now = yymm + totalDates[indexPath.item]
            if now.count == 8 {
                let lastTwoCharacters = String(now.suffix(2))
                photoDetailVC.photoDetailView.dateLabel.text = calendarHelper.monthString(date: selectedDate) + "월" + lastTwoCharacters + "일"
            } else if now.count == 7 {
                let lastCharacter = String(now.suffix(1))
                photoDetailVC.photoDetailView.dateLabel.text = calendarHelper.monthString(date: selectedDate) + "월" + lastCharacter + "일"
            } else {
                // 길이가 7 또는 8이 아닐 때의 로직
            }
            
            navigationController?.pushViewController(photoDetailVC, animated: true)
        }
        
    }
}



// MARK: - FlowLayout

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width) / 8 + 5
        let height = (collectionView.frame.size.height) / 6
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        return inset
    }
}


// MARK: - ImagePicker

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) {
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
               let selectedIndexPath = self.collectionView.indexPathsForSelectedItems?.first {
                let now = self.yymm + self.totalDates[selectedIndexPath.item]
                DispatchQueue.main.async {
                    self.thumbnails[now] = img
                    self.collectionView.reloadItems(at: [selectedIndexPath])
                }
            }
        }
    }
}
