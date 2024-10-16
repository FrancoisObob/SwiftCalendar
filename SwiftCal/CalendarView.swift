//
//  CalendarView.swift
//  SwiftCal
//
//  Created by Francois Lambert on 5/13/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct CalendarView: View {
    @Environment(\.modelContext) private var context

    static var startDate: Date { .now.startOfCalendarWithPrefixDays }
    static var endDate: Date { .now.endOfMonth}
    
    @Query(filter: #Predicate<Day> { $0.date >= startDate && $0.date < endDate }, sort: \Day.date)
    var days: [Day]

    var body: some View {
        NavigationView {
            VStack {
                CalendarHeaderView()

                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days) { day in
                        if day.date.monthInt != Date().monthInt {
                            Text("")
                        } else {
                            Text(day.date.formatted(.dateTime.day()))
                                .fontWeight(.bold)
                                .foregroundStyle(day.didStudy ? .orange : .secondary)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(
                                    Circle()
                                        .foregroundStyle(.orange.opacity(day.didStudy ? 0.3 : 0.0))
                                )
                                .onTapGesture {
                                    guard day.date.dayInt <= Date().dayInt else {
                                        print("Can't study in the future!!")
                                        return
                                    }
                                    day.didStudy.toggle()
                                    try? context.save()
                                    WidgetCenter.shared.reloadTimelines(ofKind: "SwiftCalWidget")
                                    if #available(iOS 18.0, *) {
                                        ControlCenter.shared.reloadControls(ofKind: "SwiftCalControl")
                                    }
                                }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle(Date().formatted(.dateTime.month(.wide)))
            .padding()
            .onAppear {
                if days.isEmpty {
                    createMonthDays(for: .now.startOfPreviousMonth)
                    createMonthDays(for: .now)
                } else if days.count < 10 {
                    createMonthDays(for: .now)
                }
            }
        }
    }

    func createMonthDays(for date: Date) {
        for dayOffset in 0..<date.numberOfDaysInMonth {
            let newDay = Day(date: Calendar.current.date(byAdding: .day, value: dayOffset, to: date.startOfMonth)!,
                             didStudy: false)
            context.insert(newDay)
        }
    }
}

#Preview {
    CalendarView()
}
