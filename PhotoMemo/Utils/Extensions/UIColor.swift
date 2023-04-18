//
//  UIColor.swift
//  PhotoMemo
//
//  Created by juyeong koh on 2023/04/14.
//

import UIKit

extension UIColor {
    // 나누기 255 할 필요 없음, alpha값 1로 고정
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
            }
    static let mainDarkGrey = UIColor(red: 0.287, green: 0.287, blue: 0.287, alpha: 1)
    static let newGrey = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
    static let mainGrey = UIColor(red: 0.929, green: 0.929, blue: 0.929, alpha: 1)
    static let darkRed = UIColor(red: 0.642, green: 0.107, blue: 0.107, alpha: 1)
}
