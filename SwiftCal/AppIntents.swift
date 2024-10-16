//
//  AppIntents.swift
//  SwiftCal
//
//  Created by Francois Lambert on 5/13/24.
//

import Foundation
import AppIntents
import SwiftData
import WidgetKit

struct ToggleStudyIntent: AppIntent {

    static let title: LocalizedStringResource = "Toggle Studied"

    @Parameter(title: "Date")
    var date: Date

    init(date: Date) {
        self.date = date
    }

    init() {}

    func perform() async throws -> some IntentResult {
        let context = ModelContext(Persistence.container)
        let predicate = #Predicate<Day> { $0.date == date }
        let descriptor = FetchDescriptor(predicate: predicate)

        guard let day = try! context.fetch(descriptor).first else { return .result() }
        day.didStudy.toggle()
        try! context.save()
        if #available(iOS 18.0, *) {
            ControlCenter.shared.reloadControls(ofKind: "SwiftCalControl")
        }
        return .result()
    }
}

struct ControlToggleStudyIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Control Toggle Studied"

    @Parameter(title: "Did Study")
    var value: Bool

    func perform() async throws -> some IntentResult {
        let context = ModelContext(Persistence.container)
        let today = Date().startOfDay
        let predicate = #Predicate<Day> { $0.date == today }
        let descriptor = FetchDescriptor(predicate: predicate)

        guard let day = try! context.fetch(descriptor).first else { return .result() }
        day.didStudy = value
        try! context.save()
        WidgetCenter.shared.reloadTimelines(ofKind: "SwiftCalWidget")
        return .result()
    }
}
