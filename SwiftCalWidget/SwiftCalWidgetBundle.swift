//
//  SwiftCalWidgetBundle.swift
//  SwiftCalWidget
//
//  Created by Francois Lambert on 5/13/24.
//

import WidgetKit
import SwiftUI

@main
struct SwiftCalWidgetBundle: WidgetBundle {
    var body: some Widget {
        SwiftCalWidget()
        if #available(iOSApplicationExtension 18.0, *) {
            SwiftCalControl()
        }
    }
}
