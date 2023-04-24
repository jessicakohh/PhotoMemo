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
        
        configureNavigation()
        configureUI()
        configureTableView()
    }
    
    override func loadView() {
        view = settingView
    }
    
    // MARK: - Selectors
    
    @objc func editButtonTapped() {
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        navigationItem.title = "Profile"
        navigationItem.titleView?.tintColor = .mainDarkGrey
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .mainGrey
        viewModel.fetchItems()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .mainDarkGrey
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "editButton"), style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
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
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        cell.textLabel?.textColor = .mainDarkGrey
        cell.backgroundColor = .mainGrey
        return cell
    }
    

}

