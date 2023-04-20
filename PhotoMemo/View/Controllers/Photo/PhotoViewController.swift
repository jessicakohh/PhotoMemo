//
//  PhotoViewControllers.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/13.
//

import UIKit
import SnapKit


final class PhotoViewController: UIViewController, PhotoViewDelegate {
    
    func photoViewDidTapPreviousButton(_ photoView: PhotoView) {
        selectedDate = calendarHelper.previousMonth(date: selectedDate)
        setMonthView()
    }
    
    func photoViewDidTapNextButton(_ photoView: PhotoView) {
        selectedDate = calendarHelper.nextMonth(date: selectedDate)
        setMonthView()
    }
    

    // MARK: - Properties
    
    var photoView = PhotoView()
    var realmManager = RealmManager()
    private let viewModel = PhotoViewModel()
        
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var selectedDate = Date()
    var totalDates = [String]()
    var thumbnails = [String:UIImage]()
    let calendarHelper = CalendarHelper()
    
    let picker = UIImagePickerController()
    
    var currentCalendarIndex: Int = 0
    var checkIndex = 0
    var now = ""
    var yymm = ""
 
    
    
    // MARK: - LifeCycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedDate = Date()
        configureUI()
        setMonthView()
        swipeSetting()
        
        picker.delegate = self
    }
    
    
    override func loadView() {
        view = photoView
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
    
    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
            
        photoView.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        DispatchQueue.main.async {
            if let image = self.thumbnails[self.now] {
                cell.imgView.image = image
                cell.imgView.isHidden = false
                cell.imgView.layer.cornerRadius = 2
                cell.contentView.bringSubviewToFront(cell.imgView)
            } else {
                cell.imgView.image = nil
                cell.imgView.isHidden = true
            }
        }
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        now = yymm + totalDates[indexPath.item]
        guard totalDates[indexPath.item] != "" else { return }
        
        if thumbnails[now] == nil {
            present(picker, animated: true, completion: nil)
        } else {
            checkIndex += 1
            let photoDetailVC = PhotoDetailViewController()
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
