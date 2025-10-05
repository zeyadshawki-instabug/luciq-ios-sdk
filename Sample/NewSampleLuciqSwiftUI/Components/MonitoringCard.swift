
//
//  PerformanceRow.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation
import SwiftUI

// MARK: - Monitoring Card Component

struct MonitoringCard: View {
    let title: String
    let value: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
        }
        .padding(.vertical, 8)
    }
}
