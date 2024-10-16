//
//  StreakView.swift
//  SwiftCal
//
//  Created by Francois Lambert on 5/13/24.
//

import SwiftUI
import SwiftData

struct StreakView: View {

    static var startDate: Date { .now.startOfMonth }
    static var endDate: Date { .now.endOfMonth}

    @Query(filter: #Predicate<Day> { $0.date > startDate && $0.date < endDate }, sort: \Day.date)
    var days: [Day]

    @State private var streakValue = 0

    var body: some View {
        VStack {
            Text("\(streakValue)")
                .font(.system(size: 200, weight: .semibold, design: .rounded))
                .foregroundStyle(streakValue > 0 ? .orange : .pink)
            Text("Current streak")
                .font(.title)
                .bold()
                .foregroundStyle(.secondary)
        }
        .onAppear { streakValue = calculateStreakValue() }
    }

    func calculateStreakValue() -> Int {
        guard !days.isEmpty else { return 0 }

        let pastDays = days.filter { $0.date.dayInt <= Date().dayInt }
        var streakCount = 0

        for day in pastDays.reversed() {
            if day.didStudy {
                streakCount += 1
            } else if day.date.dayInt != Date().dayInt {
                break
            }
        }

        return streakCount
    }
}

#Preview {
    StreakView()
}
