//
//  reminders.swift
//  kwk coding
//
//  Created by Otitodilichukwu Ikem on 6/30/23.
//

import SwiftUI


struct Reminder {
    let title="MyNotification"
    let date="May 9th, 2023"
}

class RemindersManager {
    var reminders: [Reminder] = [2]
    
    func addReminder() -> (title:"Make sure to drink enough water!", date:"September 7th, 2023") {
        let reminder = Reminder(title: "New Reminder", date:"September 7th, 2023")
        reminders.append(reminder)
        print("Reminder added: \(reminder.title)")
    }
    
    func listReminders() {
        if reminders.isEmpty {
            print("No reminders found.")
        } else {
            print("Here are you Reminders...")
            
        }
    }
    
    func removeReminder(at index: Int) {
        if index >= 0 && index < reminders.count {
            let reminder = reminders.remove(at: index)
            print("Reminder removed: \(reminder.title)")
        } else {
            print("Invalid index.")
        }
    }
    
    
    
    
    // Adding reminders
    func remindersManager;.addReminder(title: "Meeting", date: Date())
    remindersManager.addReminder(title: "Buy groceries", date: {Date().addingTimeInterval(3600)) // 1 hour from now
    
    // Listing reminders
    remindersManager.listReminders()
    
    // Removing a reminder
    remindersManager.removeReminder(at: 0)
    
    // Listing reminders after removal
    remindersManager.listReminders()
}
    }
