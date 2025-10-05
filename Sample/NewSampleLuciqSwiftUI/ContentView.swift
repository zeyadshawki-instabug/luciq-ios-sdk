//
//  ContentView.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 29/09/2025.
//

import SwiftUI
import LuciqSDK

struct ContentView: View {
    @StateObject private var monitoringService = SystemMonitoringService.shared
    
    init() {
        Luciq.sdkDebugLogsLevel = .verbose
        // Start timing measurement
        SystemMonitoringService.shared.startTiming()
        
        // Initialize Luciq SDK with centralized configuration
        Luciq.start(withToken: Configuration.appToken, invocationEvents: [.shake, .floatingButton])
        
        // End timing measurement
        SystemMonitoringService.shared.endTiming()
    }
    
    var body: some View {
        TabView {
          
            // Info Tab
            InfoPage()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
            // Performance Tab
            PerformancePage()
                .tabItem {
                    Image(systemName: "gauge")
                    Text("Performance")
                }
            
            // Features Tab
            LuciqFeaturesPage()
                .tabItem {
                    Image(systemName: "star")
                    Text("Features")
                }
            
         
            
           
        }
        .environmentObject(monitoringService)
    }
}

#Preview {
    ContentView()
}
