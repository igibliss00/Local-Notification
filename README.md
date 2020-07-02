# Local Notification

An iOS app to demonstrate the push notification generated locally.  

## Features

<img src="https://github.com/igibliss00/Local-Notification/blob/master/README_assets/1.png" width="400">

<img src="https://github.com/igibliss00/Local-Notification/blob/master/README_assets/2.png" width="400">

<img src="https://github.com/igibliss00/Local-Notification/blob/master/README_assets/3.png" width="400">

### UserNotifications

Push user-facing notifications to the user's device from a server, or generate them locally from your app. User-facing notifications communicate important information to users of your app, regardless of whether your app is running on the user's device. For example, a sports app can let the user know when their favorite team scores. Notifications can also tell your app to download information and update its interface. Notifications can display an alert, play a sound, or badge the app's icon.

You can generate notifications locally from your app or remotely from a server that you manage. For local notifications, the app creates the notification content and specifies a condition, like a time or location, that triggers the delivery of the notification. For remote notifications (also known as push notifications), you use one of your company's servers to generate notifications, and Apple Push Notification service (APNs) handles the delivery of those notifications to the user's devices. 
Use this framework to:
* Define the types of notifications that your app supports. 
* Define any custom actions associated with your notification types. 
* Schedule local notifications for delivery. 
* Process already delivered notifications. 
* Respond to user-selected actions. 
Every attempt is made to deliver local and remote notifications in a timely manner, but delivery isn’t guaranteed. The PushKit framework offers a more timely delivery mechanism for specific types of notifications, such as those used for VoIP and watchOS complications. For more information, see PushKit. ([Source](https://developer.apple.com/documentation/usernotifications))

### UNMutableNotificationContent

The editable content for a notification. Create a UNMutableNotificationContent object when you want to specify the payload for a local notification. Specifically, use this object to specify the title and message for an alert, the sound to play, or the value to assign to your app's badge. You might also provide details about how the system handles the notification. For example, you can specify a custom launch image and a thread identifier for visually grouping related notifications. 
After creating your content object, assign it to a UNNotificationRequest object, add a trigger condition, and schedule your notification. The trigger condition defines when the notification is delivered to the user. Listing 1 shows the scheduling of a local notification that displays an alert and plays a sound after a delay of five seconds. The strings for the alert's title and body are stored in the app’s Localizable.strings file. ([Source](https://developer.apple.com/documentation/usernotifications/unmutablenotificationcontent))

```
let content = UNMutableNotificationContent()
content.title = "Title"
content.body = "Main text for the notification"
content.categoryIdentifier = "customIdentifier"
content.userInfo = ["customData": "fizzbuzz"]
content.sound = UNNotificationSound.default
```

### UNNotificationAction

A task to perform in response to a delivered notification. Use UNNotificationAction objects to define the actions that your app can perform in response to a delivered notification. You define the actions that your app supports. For example, a meeting app might define actions for accepting or rejecting a meeting invitation. The action object itself contains the title to display in an action button and the button's appearance. After creating action objects, add them to a UNNotificationCategory object and register your categories with the system. ([Source](https://developer.apple.com/documentation/usernotifications/unnotificationaction))

Actionable notifications let the user respond to a notification directly from the notification interface. In addition to the notification's content, an actionable notification displays one or more buttons representing the actions that the user can take. Tapping one of the buttons forwards the selected action to your app, without bringing the app to the foreground. If your app supports actionable notification types, you must handle the associated actions. ([Source](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions))

```
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
}

```

You handle selected actions from the delegate object of the shared UNUserNotificationCenter object. When the user selects an action, the system launches your app in the background and calls the delegate’s userNotificationCenter(_:didReceive:withCompletionHandler:) method. Match the value in the actionIdentifier property of the response object to one of your app's actions. Be prepared for the action identifier to match one of the system-defined actions as well. The system reports special actions when the user dismisses the notification or launches your app. 

