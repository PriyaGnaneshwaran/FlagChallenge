//
//  ScheduleViewModel.swift
//  FlagsChallange
//
//  Created by Priya Gnaneshwaran on 25/07/25.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var selectedDate: Date?
    @Published var hasSavedTime =  false
    
    private let storageKey = "scheduledTime"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        loadSavedTime()
    }
    
    func saveSelectedDate(_ date: Date?) {
        selectedDate = date
        UserDefaults.standard.set(date, forKey: storageKey)
        hasSavedTime = date != nil
    }

    func clearSchedule() {
        selectedDate = nil
        hasSavedTime = false
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
    private func loadSavedTime() {
        if let savedDate = UserDefaults.standard.object(forKey: storageKey) as? Date {
            selectedDate = savedDate
            hasSavedTime = true
        }
    }
}
