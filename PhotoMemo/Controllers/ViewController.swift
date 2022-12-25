//
//  ViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let diaryManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // 화면에 다시 진입할때마다 테이블뷰 리로드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryManager.getDiaryListFromCoreData().count
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
        cell.selectionStyle = .none
        return cell
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
