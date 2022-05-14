//
//  Messnger_newApp.swift
//  Shared
//
//  Created by Алексей Дробный on 10.05.2022.
//

import SwiftUI

@main
struct Messnger_newApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}

extension NSTextField{
    open override var focusRingType: NSFocusRingType{
        get{.none}
        set{}
    }
}



