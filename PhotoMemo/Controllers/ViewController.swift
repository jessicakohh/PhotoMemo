//
//  ViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let diaryManager = CoreDataManager.shared
    private let memoManager = MemoManager.shared
    
    private let refreshController: UIRefreshControl = UIRefreshControl()
    private var savedCoreArray: [Diary] = [] {
        didSet {
            tableView.reloadData()
            print("Total ViewController savedCoreArray changed \n \(savedCoreArray)")
        }
    }
    var diaryData: Diary? {
        didSet {
            print("여기 수정")
        }
    }
    
    // searchBar를 통해 array가 필터링 되어졌는지에 대한 bool값 변수
    var isFiltering: Bool = false
    // filter (서치바를 통해 작성한 무언가)를 담는 리스트
    var filteredArr: [String] = []
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        setupSearchBar()
    }
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedCoreArray = diaryManager.getDiaryListFromCoreData()
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.separatorInset.left = 10
        tableView.separatorInset.right = 10
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(self.refreshFunc), for: .valueChanged)
        savedCoreArray = diaryManager.getDiaryListFromCoreData()

    }
    
    @objc func refreshFunc() {
        savedCoreArray = diaryManager.getDiaryListFromCoreData()
        tableView.reloadData()
        refreshController.endRefreshing()
    }
    
//    func setupSearchBar() {
//        searchBar.delegate = self
//        searchBar.placeholder = "검색할 내용을 입력하세요."
//    }
}



extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredArr.count : savedCoreArray.count
//        return savedCoreArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
        // 셀에 모델(Diary) 전달
        let diaryData = diaryManager.getDiaryListFromCoreData()
        cell.diaryData = diaryData[indexPath.row]
        // 셀 위에 있는 버튼이 눌렸을 때 (뷰컨에서) 어떤 행동을 하기 위해서 클로저 전달
        cell.updateButtonPressed = { [weak self] (senderCell) in
            self?.performSegue(withIdentifier: "MemoCell", sender: indexPath)
        }
//        if isFiltering {
//            cell.titleTextLabel?.text = self.filteredArr[indexPath.row]
//        } else {
//            cell.titleTextLabel.text = savedCoreArray[indexPath.row]
//        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    // MARK: - 스와이프하여 삭제
    
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
}

    
    extension ViewController: UITableViewDelegate {
        
        // 셀 선택했을 때 다음화면
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "MemoCell", sender: indexPath)
        }
        
        
        // 세그웨이를 실행할 때 실제 데이터 전달 (Diary)
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "MemoCell" {
                let detailVC = segue.destination as! DetailViewController
                guard let indexPath = sender as? IndexPath else { return }
                detailVC.diaryData = diaryManager.getDiaryListFromCoreData()[indexPath.row]
            }
        }
        
    }
    


// MARK: - SearchBar
//
//extension ViewController: UISearchBarDelegate {
//    // 서치바에서 검색을 시작할 때 호출
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        isFiltering = true
//        searchBar.showsCancelButton = true
//        tableView.reloadData()
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard let text = searchBar.text?.lowercased() else { return }
//        filteredArr = arr.filter { $0.localizedCaseInsensitiveContains(text) }
//
//        self.tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        isFiltering = false
//        tableView.reloadData()
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        tableView.reloadData()
//    }
//
//    override func dismissKeyboard() {
//        searchBar.resignFirstResponder()
//    }
//}
//
