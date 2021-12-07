//
//  File.swift
//  
//
//  Created by Yue Cai on 2021/12/6.
//

import UIKit

// For scrollable content, the default behavior is, scroll up will increases the detent instead of scrolling the sheet's content. So, you can't scroll your content in a medium height.
// To make the content scrollable in a medium detent, you have to set prefersScrollingExpandsWhenScrolledToEdge to false.
// This method return the nav, you could animate the changes
// ===== code block =====
// if let sheet = nav.sheetPresentationController {
//     sheet.animateChanges {
//         sheet.selectedDetentIdentifier = .medium
//     }
// }
// ===== code block =====
//
public struct BottomSheet {
    @available(iOS 15.0, *)
    public static func show(
        _ containerViewController: UIViewController,
        in sourceViewController: UIViewController,
        using configuration: BottomSheetConfiguration = .defaultSheetConfiguration()
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: containerViewController)
        nav.modalPresentationStyle = .pageSheet
        nav.isModalInPresentation = configuration.alwaysOnScreen
        if let sheet = nav.sheetPresentationController {
            sheet.preferredCornerRadius = configuration.preferredCornerRadius
            sheet.detents = configuration.supportedDetents.map { $0.uikitDetent }
            sheet.prefersScrollingExpandsWhenScrolledToEdge = configuration.prefersScrollingExpandsWhenScrolledToEdge
            sheet.largestUndimmedDetentIdentifier = configuration.largestUndimmedDetent?.detentIdetifier
            sheet.selectedDetentIdentifier = configuration.initialDetent.detentIdetifier
        }
        sourceViewController.present(nav, animated: true, completion: nil)
        return nav
    }
}

public struct BottomSheetConfiguration {
    
    public enum Detent {
        case medium
        case large
        
        @available(iOS 15.0, *)
        var uikitDetent: UISheetPresentationController.Detent {
            switch self {
            case .medium:
                return .medium()
            case .large:
                return .large()
            }
        }
        
        @available(iOS 15.0, *)
        var detentIdetifier: UISheetPresentationController.Detent.Identifier {
            switch self {
            case .medium:
                return .medium
            case .large:
                return .large
            }
        }
    }
    
    public var alwaysOnScreen: Bool // to prevent the drag gesture dismissal.
    public var preferredCornerRadius: CGFloat? // default is nil
    public var prefersGrabberVisible: Bool
    public var prefersScrollingExpandsWhenScrolledToEdge: Bool
    public var supportedDetents: [Detent]
    public var initialDetent: Detent
    public var largestUndimmedDetent: Detent? //  You specified the largest detent that you doesn’t want to put a dimming view underneath to largestUndimmedDetentIdentifier. Anything larger than that will has a dimming view.
    
    public static func defaultSheetConfiguration() -> BottomSheetConfiguration {
        let sheetConfiguration = BottomSheetConfiguration(alwaysOnScreen: false, preferredCornerRadius: nil, prefersGrabberVisible: false, prefersScrollingExpandsWhenScrolledToEdge: true, supportedDetents: [.medium, .large], initialDetent: .medium, largestUndimmedDetent: nil)
        return sheetConfiguration
    }
}
