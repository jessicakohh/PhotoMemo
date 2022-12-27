//
//  SideMenuViewController.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2022/12/25.
//

import UIKit
import MessageUI
import SafariServices

class SideMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - 문의하기

extension SideMenuViewController: MFMailComposeViewControllerDelegate {
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "아이폰 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) {
            (action) in
            print("확인")
        }
        sendMailErrorAlert.addAction(confirmAction)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }

    @IBAction func sendMailButtonTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let compseVC = MFMailComposeViewController()
            compseVC.mailComposeDelegate = self
            compseVC.setToRecipients(["본 메일을 전달받을 이메일 주소"])
            compseVC.setSubject("문의 제목")
            compseVC.setMessageBody("문의 내용", isHTML: false)
            self.present(compseVC, animated: true, completion: nil)
        }
        else {
            self.showSendMailErrorAlert()
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
