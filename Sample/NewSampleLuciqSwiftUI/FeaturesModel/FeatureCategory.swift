//
//  FeatureCategory.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation

// MARK: - Feature Categories

 enum FeatureCategory: String, CaseIterable, Identifiable {
    case core = "Luciq SDK"
    case userManagement = "User Management"
    case bugReporting = "Bug Reporting"
    case apm = "APP Performance Monitoring"
    case surveys = "Surveys & Feedback"
    case attachments = "File Attachments"
    case featureFlags = "Feature Flags"
    case Customization = "UI Customization"
    case tags = "Tags & Experiments"
    case testing = "Testing & Debugging"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .core: return "🚀"
        case .userManagement: return "👤"
        case .bugReporting: return "🐛"
        case .apm: return "📊"
        case .surveys: return "📋"
        case .attachments: return "📎"
        case .featureFlags: return "🏷️"
        case .Customization: return "🎨"
        case .tags: return "🧪"
        case .testing: return "🔧"
        }
    }
}
