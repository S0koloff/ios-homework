//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Sokolov on 01.03.2023.
//

import UIKit
import UserNotifications

class LocalNotificationService: NSObject {
    
    func registeForLatesUpdatesIfPossible(_ registeNotification: @escaping (Bool) -> Void) {
        registerUpdatesCategory()
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { success, error in
            if success {
                registeNotification(success)
            } else {
                registeNotification(false)
            }
        }
    }
    
    func notification() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Updates"
        content.body = "Check the last updates"
        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
        content.categoryIdentifier = "Updates"
        
        var components = DateComponents()
        components.hour = 19
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
}

extension LocalNotificationService: UNUserNotificationCenterDelegate {
    
    func registerUpdatesCategory() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let actionShow = UNNotificationAction(identifier: "ShowPatchNotes", title: "Show more", options: .foreground)
        
        let updates = UNNotificationCategory(identifier: "Updates", actions: [actionShow], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([updates])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
            
        case UNNotificationDefaultActionIdentifier:
            print("Default Identifier")
        case "ShowPatchNotes":
            print("Show more info")
        default:
            break
        }
        
        completionHandler()
    }
}
