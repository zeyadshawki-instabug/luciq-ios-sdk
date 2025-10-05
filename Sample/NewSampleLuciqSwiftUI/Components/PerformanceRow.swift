//
//  PerformanceRow.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation
import SwiftUI

// MARK: - Performance Row Component
struct PerformanceRow: View {
    let title: String
    let value: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
        .padding(.vertical, 8)
    }
}
