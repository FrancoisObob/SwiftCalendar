//
//  Day.swift
//  SwiftCal
//
//  Created by Francois Lambert on 5/13/24.
//
//

import Foundation
import SwiftData

@Model public class Day {
    var date: Date
    var didStudy: Bool

    init(date: Date, didStudy: Bool) {
        self.date = date
        self.didStudy = didStudy
    }
}
