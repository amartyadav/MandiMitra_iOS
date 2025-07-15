//
//  NotificationHandler.swift
//  Mandi Mitra
//
//  Created by Amartya Yadav on 06/03/24.
//

import Foundation
import UserNotifications

func requestNotificationPermission(launchedFrom: String) {
    print("Notification permission requested from \(launchedFrom)")
    let hasRequestedNotificationPermission = UserDefaults.standard.bool(forKey: "HasRequestedNotificationPermission")
    
    if !hasRequestedNotificationPermission {
        UserDefaults.standard.set(true, forKey: "HasRequestedNotificationPermission")
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted")
                UserDefaults.standard.setValue(true, forKey: "NotificationPermissionGranted")
                scheduleNotifications()
//                scheduleTestNotifications(hour: 17, minute: 45, message: "Sabzi waale bhaiya telling the rate in kilo when you only want a paao? Use Mandi Mitra to simplify the experience!")
            }
            else {
                print("Notification permission denied")
            }
        }
    }
    }

func scheduleNotifications() {
    print("scheduleNotifications called")
    let notificationHours = [10, 13, 16, 19] // 10am, 1pm, 4pm, 7pm
    let messages = [
        "Is your sabzi list ready? Don't forget to use Mandi Mitra at the Sabzi Mandi!",
        "Sabzi shopping today? Let's make it fun with Mandi Mitra!",
        "Skip the mental maths while buying sabzi at the mandi. Open Mandi Mitra now!",
        "Mandi Mitra at your service for the smartest Sabzi shopping experience!",
        "Never overpay for your Sabzi again. Check the rates on Mandi Mitra!",
        "Sabzi waale bhaiya telling the rate in kilo when you only want a paao? Use Mandi Mitra to simplify the experience!",
        "Ready for some sabzi shopping? Let Mandi Mitra handle the math for you!",
        "Heading to the sabzi mandi? Make it effortless with Mandi Mitra by your side!",
        "Mandi shopping just got smarter. Use Mandi Mitra for accurate sabzi calculations!",
        "Save time and money at the sabzi mandi with Mandi Mitra!",
        "Tired of haggling over sabzi prices? Let Mandi Mitra do the calculations!",
        "Your sabzi shopping assistant is here! Open Mandi Mitra at the mandi!",
        "Stay ahead of the game at the sabzi mandi. Use Mandi Mitra for instant price calculations!",
        "No more guesswork at the sabzi mandi. Mandi Mitra gives you the exact costs!",
        "Simplify your sabzi shopping experience with Mandi Mitra!",
        "Mandi Mitra ensures you never overpay for your sabzi again. Check it out now!"
    ]
    
    for i in 0..<notificationHours.count {
        let content = UNMutableNotificationContent()
        content.title = "Go Grocery Shooping with Mandi Mitra"
        content.body = messages[i % messages.count]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = notificationHours[i]
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
            else {
                print("Notifications scheduled")
            }
        }
    }
}

func scheduleTestNotifications(hour: Int, minute: Int, message: String) {
    print("function test notification scheduler called")
    let content = UNMutableNotificationContent()
    content.title = "Test Mandi Mitra"
    content.body = message
    content.sound = UNNotificationSound.default
    
    var dateComponenets = DateComponents()
    dateComponenets.hour = hour
    dateComponenets.minute = minute
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponenets, repeats: true)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling test notification: \(error)")
        }
        else {
            print("Test notification sheduled forb \(hour): \(minute)")
        }
    }
}


