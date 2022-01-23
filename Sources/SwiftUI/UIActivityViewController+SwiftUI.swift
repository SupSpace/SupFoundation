//
//  File.swift
//  
//
//  Created by Yue Cai on 2022/1/15.
//

import UIKit
import SwiftUI

public struct ActivityViewController: UIViewControllerRepresentable {

    public init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }
    
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]? = nil

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {
    }

}
