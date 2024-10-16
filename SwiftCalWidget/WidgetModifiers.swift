//
//  WidgetModifiers.swift
//  SwiftCal
//
//  Created by Francois Lambert on 10/16/24.
//

import SwiftUI

struct DidStudyAccent: ViewModifier {
    let didStudy: Bool

    func body(content: Content) -> some View {
        if #available(iOS 16, *), didStudy {
            content.widgetAccentable()
        } else {
            content
        }
    }
}

extension View {
    public func didStudyAccent(_ didStudy: Bool) -> some View {
        modifier(DidStudyAccent(didStudy: didStudy))
    }
}
