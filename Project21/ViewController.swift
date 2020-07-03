//
//  ViewController.swift
//  Project21
//
//  Created by jc on 2020-07-02.
//  Copyright © 2020 J. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("Not authorized")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Wake up alarm"
        content.body = "Wake me up when the quarantine ends"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let alert = UNNotificationAction(identifier: "alert", title: "Alert will pop up", options: .foreground)
        let reminder = UNNotificationAction(identifier: "reminder", title: "Another reminder in 5 seconds", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, alert, reminder], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // the useswipedr  to unlock
                print("Default identifier")
            case "show":
                // the user tapped our "show more info…" button
                print("Show more information…")
            case "alert":
                let ac = UIAlertController(title: "Awesome Alert", message: "Surprise!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(ac, animated: true)
            case "reminder":
                scheduleLocal()
            default:
                break
            }
        }
        // you must call the completion handler when you're done
        completionHandler()
    }
}

