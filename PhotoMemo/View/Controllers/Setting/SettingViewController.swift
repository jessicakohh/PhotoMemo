//
//  SettingViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit
import SnapKit
import Firebase
import Kingfisher

final class SettingViewController: UIViewController {

    // MARK: - Properties
    
    var settingView = SettingView()
    lazy var tableView = settingView.tableView
    var viewModel = SettingViewModel()
    
    private var userModel: UserModel?


    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        UserService.shared.fetchUser { [weak self] userModel in
             self?.userModel = userModel
             self?.configureUI()
         }
        
        configureNavigation()
        configureTableView()
    }
    
    override func loadView() {
        view = settingView
    }
    
    // MARK: - Selectors
    
    @objc func editButtonTapped() {
        self.navigationController?.pushViewController(EditViewController(), animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        UserService.shared.fetchUser { [weak self] userModel in
            self?.settingView.nameTextField.text = userModel.username
            
            // Set the profile image to a default image first
            self?.settingView.profileImage.image = UIImage(named: "saveButton")

            if let imageUrlString = userModel.profileImageUrl {
                UserService.shared.downloadImage(from: imageUrlString) { image in
                    DispatchQueue.main.async {
                        self?.settingView.profileImage.image = image
                    }
                    print("여기여기 \(userModel.profileImageUrl)")
                }
            }
        }
    }

                



    private func configureTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .mainGrey
        viewModel.fetchItems()
    }
    
    private func configureNavigation() {
        navigationItem.title = "Profile"
        navigationItem.titleView?.tintColor = .mainDarkGrey
        navigationController?.navigationBar.tintColor = .mainDarkGrey
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "editButton"), style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
    }

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

