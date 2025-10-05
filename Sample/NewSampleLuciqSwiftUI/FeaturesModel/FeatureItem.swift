//
//  FeatureItem.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation

// MARK: - Feature Items

struct FeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let action: () -> Void
    let icon: String
    
    init(title: String, description: String, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.icon = icon
        self.action = action
    }
}
