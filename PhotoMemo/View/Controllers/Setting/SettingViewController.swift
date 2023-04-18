//
//  SettingViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {

    // MARK: - Properties
    
    var settingView = SettingView()
    lazy var tableView = settingView.tableView
    
    var viewModel = SettingViewModel()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    override func loadView() {
        view = settingView
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "Profile"
        navigationItem.titleView?.tintColor = .mainDarkGrey
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        viewModel.fetchItems()
    }
    
    // MARK: - Layout Extension


}


// MARK: - TableView

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel.items[indexPath.row]
        return cell
    }
    

}

