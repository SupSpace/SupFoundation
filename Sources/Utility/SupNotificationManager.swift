//
//  File.swift
//  
//
//  Created by Yue Cai on 2021/12/12.
//

import Foundation
import UserNotifications

/// The manager which enwrap the user notifications, only local for now
final public class SupNotificationManager {
    
    public enum NotificationContentType {
        case alert(title: String, body: String)
        case badge
        case sound
    }
    
    public static let `default` = SupNotificationManager()
    
    /// Request the authorization on user
    /// - Parameters:
    ///   - options: the option authorization which you want to authorize
    ///   - completionHandler: The block to execute asynchronously with the results. This block may be executed on a background thread.
    public func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: options) { granted, error in
            if let error = error {
                Log.error("Request notification authorization error: \(error.localizedDescription)")
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(()))
        }
    }
    
    /// Schedule a notification to user
    /// - Parameters:
    ///   - content: the content of notification
    ///   - completionHandler: The block to execute asynchronously with the results. This block may be executed on a background thread. 
    public func scheduleNotification(content: NotificationContentType, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized) || (settings.authorizationStatus == .provisional) else {
                Log.error("The user has not authorize the notification permission")
                return
            }
            if case let .alert(title, body) = content, settings.alertSetting == .enabled {
                Log.success("Start scheduling the alert notification with title: \(title) and body: \(body)")
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        Log.error("Schedule notification error: \(error.localizedDescription)")
                        completionHandler(.failure(error))
                        return
                    }
                    completionHandler(.success(()))
                }
            } else {
                Log.error("The alert setting notification authorization may not be enabled in user's setting")
            }
        }
    }
}
