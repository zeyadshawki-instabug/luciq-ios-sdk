//
//  SystemMonitoringService.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 29/09/2025.
//

import Foundation
import os.signpost
import UIKit
import LuciqSDK

@MainActor
class SystemMonitoringService: ObservableObject {
    static let shared = SystemMonitoringService()
        
    // MARK: - Published Properties
    @Published var cpuUsage: Double = 0.0
    @Published var memoryUsage: Double = 0.0
    @Published var memoryUsed: UInt64 = 0
    @Published var memoryTotal: UInt64 = 0
    @Published var diskUsage: Double = 0.0
    @Published var diskUsed: UInt64 = 0
    @Published var diskTotal: UInt64 = 0
    @Published var appMemoryFootprint: UInt64 = 0
    @Published var sdkLaunchOverHead: TimeInterval = 0.0

    
    // MARK: - Private Properties
    private var timer: Timer?
    private let signpostLog = OSLog(subsystem: "com.luciq.monitoring", category: "SystemMonitoring")
    private var signpostStartTime: CFTimeInterval = 0
    
    private init() {
        // Initialize CPU monitoring and calculate initial metrics
        updateSystemMetrics()
        startMonitoring()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Public Methods
    
    func startMonitoring() {
        // Only start monitoring if not already running
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                Task { @MainActor in
                    self?.updateSystemMetrics()
                }
            }
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Signpost Overhead Measurement
    
    func startSignpostMeasurement() {
        signpostStartTime = CACurrentMediaTime()
    }
    
    func endSignpostMeasurement() {
        let endTime = CACurrentMediaTime()
        let overhead = endTime - signpostStartTime
        sdkLaunchOverHead = overhead
    }
    
    // MARK: - Timing Measurement Methods
    
    func startTiming() {
        startSignpostMeasurement()
    }
    
    func endTiming() {
        endSignpostMeasurement()
    }
    
    // MARK: - SDK State Management
    
    func calculateSDKLaunchTime() {
        // Only initialize SDK if it hasn't been initialized before
        // Start timing measurement
        startSignpostMeasurement()
        
        // Initialize Luciq SDK
        Luciq.start(withToken: Configuration.appToken, invocationEvents: .shake)
        
        // End timing measurement
        endSignpostMeasurement()
        
        startMonitoring()
    }
    
    // MARK: - Private Methods
    
    private func updateSystemMetrics() {
        cpuUsage = getCurrentCPUUsage()
        updateMemoryMetrics()
        updateDiskMetrics()
        appMemoryFootprint = getCurrentMemoryUsage()
    }
    
    private func getCurrentCPUUsage() -> Double {
        var info = host_cpu_load_info()
        var count = mach_msg_type_number_t(MemoryLayout<host_cpu_load_info>.size / MemoryLayout<integer_t>.size)
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics(mach_host_self(),
                               HOST_CPU_LOAD_INFO,
                               $0,
                               &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            let userTicks = Double(info.cpu_ticks.0)
            let systemTicks = Double(info.cpu_ticks.1)
            let idleTicks = Double(info.cpu_ticks.2)
            let niceTicks = Double(info.cpu_ticks.3)
            
            let totalTicks = userTicks + systemTicks + idleTicks + niceTicks
            let usedTicks = userTicks + systemTicks + niceTicks
            
            if totalTicks > 0 {
                return min(usedTicks / totalTicks, 1.0)
            }
        }
        
        return 0.0
    }
    
    private func updateMemoryMetrics() {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            memoryUsed = UInt64(info.resident_size)
            memoryTotal = UInt64(ProcessInfo.processInfo.physicalMemory)
            memoryUsage = Double(memoryUsed) / Double(memoryTotal)
        }
    }
    
    private func updateDiskMetrics() {
        do {
            let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            if let totalSize = systemAttributes[.systemSize] as? NSNumber,
               let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
                diskTotal = totalSize.uint64Value
                diskUsed = diskTotal - freeSize.uint64Value
                diskUsage = Double(diskUsed) / Double(diskTotal)
            }
        } catch {
            print("Error getting disk usage: \(error)")
        }
    }
    
    private func getCurrentMemoryUsage() -> UInt64 {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            return UInt64(info.resident_size)
        }
        
        return 0
    }
    
    
    // MARK: - Helper Methods
    
    func formatBytes(_ bytes: UInt64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }
    
    func formatPercentage(_ value: Double) -> String {
        return String(format: "%.1f%%", value * 100)
    }
}

