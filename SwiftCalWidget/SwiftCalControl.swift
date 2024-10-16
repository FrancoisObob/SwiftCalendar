//
//  SwiftCalControl.swift
//  SwiftCal
//
//  Created by Francois Lambert on 10/16/24.
//

import SwiftUI
import WidgetKit

@available(iOS 18.0, *)
struct SwiftCalControl: ControlWidget {
    let kind: String = "SwiftCalControl"

    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: kind) {
            ControlWidgetToggle("Study Swift",
                                isOn: Persistence.currentDay?.didStudy ?? false,
                                action: ControlToggleStudyIntent()) { isOn in
                Label(isOn ? "Studied Swift" : "Study Swift", systemImage: isOn ? "checkmark.circle" : "swift")
            }
                                .tint(.orange)
        }
        .displayName("Swift Study Calendar")
        .description("Track days you study Swift with streaks.")
    }
}
