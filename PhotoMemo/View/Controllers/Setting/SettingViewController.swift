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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUser { [weak self] userModel in
            self?.configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTableView()
        
        settingView.delegate = self

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
        DispatchQueue.main.async { [weak self] in
            guard let userModel = self?.viewModel.userModel else { return }
            self?.settingView.nameTextField.text = userModel.username
            self?.settingView.profileImage.image = UIImage(named: "daefaultImage")
            
            self?.viewModel.downloadProfileImage { image in
                DispatchQueue.main.async {
                    self?.settingView.profileImage.image = image
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



extension SettingViewController: SettingViewDelegate {
    func handleLogout() {
        AuthManager.shared.logUserOut { success in
              if success {
                  DispatchQueue.main.async {
                      let nav = UINavigationController(rootViewController: LoginViewController())
                      nav.modalPresentationStyle = .fullScreen
                      if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
                          rootViewController.present(nav, animated: true, completion: nil)
                      }
                  }
                  print("DEBUG : 로그아웃 성공")
              } else {
                  print("DEBUG : 로그아웃 실패")
              }
          }
    }
}
