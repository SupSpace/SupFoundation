//
//  File.swift
//  
//
//  Created by Yue Cai on 2021/12/6.
//

import UIKit

public struct BottomSheet {
    public static func show(
        _ containerViewController: UIViewController,
        in sourceViewController: UIViewController
    ) {
        let nav = UINavigationController(rootViewController: containerViewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
            }
            sourceViewController.present(nav, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}
