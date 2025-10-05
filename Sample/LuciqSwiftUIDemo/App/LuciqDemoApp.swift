//
//  LuciqDemoApp.swift
//  LuciqSwiftUIDemo
//
//  Copyright © 2025 Luciq. All rights reserved.
//

import SwiftUI
import LuciqSDK

@main
struct LuciqDemoApp: App {
    
    private let appToken = ""
    
    init() {
        Luciq.start(withToken: appToken, invocationEvents: .floatingButton)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
