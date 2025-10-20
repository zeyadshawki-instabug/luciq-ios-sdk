//
//  NewSampleLuciqSwiftUIApp.swift
//  NewSampleLuciqSwiftUI
//
//  Created by Luciq on 29/09/2025.
//

import SwiftUI
import LuciqSDK
import os

@main
struct NewSampleLuciqSwiftUIApp: App {
    
    init() {
        // Enable network logging before starting Luciq SDK
        NetworkLogger.enabled = true
        
        // Enable debug logs for SDK
        Luciq.sdkDebugLogsLevel = .debug
        
        // Start Luciq SDK
        Luciq.start(withToken: Configuration.appToken, invocationEvents: [.shake, .floatingButton])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
