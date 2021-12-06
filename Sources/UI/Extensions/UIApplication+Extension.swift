//
//  UIApplication+Extension.swift
//  
//
//  Created by Yue Cai on 2021/12/6.
//

import UIKit

extension UIApplication {
    static var mainWindow: UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        return keyWindow
    }
}
