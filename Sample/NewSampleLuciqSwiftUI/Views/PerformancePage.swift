//
//  PerformancePage.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 29/09/2025.
//

import SwiftUI
import LuciqSDK

struct PerformancePage: View {
    @EnvironmentObject var monitoringService: SystemMonitoringService
    
    var body: some View {
        NavigationView {
            ScrollView {
                    // SDK Impact Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("SDK Performance Impact")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            PerformanceRow(
                                title: "Initialization Time",
                                value:    String(format: "%.3f s", monitoringService.sdkLaunchOverHead) ,
                                description: "SDK startup time",
                                color: .orange
                            )
                       
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Total App Usage Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Total App Usage")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 12) {
                            MonitoringCard(
                                title: "Memory Usage",
                                value: monitoringService.memoryTotal > 0 ?
                                    "\(monitoringService.formatBytes(monitoringService.memoryUsed)) / \(monitoringService.formatBytes(monitoringService.memoryTotal))" : "N/A",
                                progress: monitoringService.memoryTotal > 0 ? monitoringService.memoryUsage : 0.0,
                                color: monitoringService.memoryTotal > 0 ? .blue : .gray
                            )
                            
                            MonitoringCard(
                                title: "Disk Usage",
                                value: monitoringService.diskTotal > 0 ?
                                    "\(monitoringService.formatBytes(monitoringService.diskUsed)) / \(monitoringService.formatBytes(monitoringService.diskTotal))" : "N/A",
                                progress: monitoringService.diskTotal > 0 ? monitoringService.diskUsage : 0.0,
                                color: monitoringService.diskTotal > 0 ? .green : .gray
                            )
                            
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // CPU Usage Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("CPU Usage")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        MonitoringCard(
                            title: "CPU Usage",
                            value: monitoringService.cpuUsage > 0 ? 
                                monitoringService.formatPercentage(monitoringService.cpuUsage) : "N/A",
                            progress: monitoringService.cpuUsage > 0 ? monitoringService.cpuUsage : 0.0,
                            color: monitoringService.cpuUsage > 0 ? .purple : .gray
                        )
                      
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Performance")
            .onAppear {
                // Start signpost measurement when PerformancePage is initialized
                monitoringService.startSignpostMeasurement()
              
            }
          
        }
    }


#Preview {
    PerformancePage()
        .environmentObject(SystemMonitoringService.shared)
}
