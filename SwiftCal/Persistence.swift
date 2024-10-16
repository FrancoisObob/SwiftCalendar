//
//  Persistence.swift
//  SwiftCal
//
//  Created by Francois Lambert on 5/13/24.
//

import Foundation
import SwiftData

struct Persistence {
    static var container: ModelContainer {
        let container: ModelContainer = {
            let sharedStoreURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.flambert.SwiftCalApp")!.appendingPathComponent("SwiftCal.sqlite")
            let config = ModelConfiguration(url: sharedStoreURL)
            return try! ModelContainer(for: Day.self, configurations: config)
        }()
        return container
    }

    static var currentDay: Day? {
        let context = ModelContext(Persistence.container)
        let today = Date().startOfDay
        let predicate = #Predicate<Day> { $0.date == today }
        let descriptor = FetchDescriptor(predicate: predicate)

        return try? context.fetch(descriptor).first
    }
}
