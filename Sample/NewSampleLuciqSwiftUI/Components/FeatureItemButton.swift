//
//  FeatureItemButton.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation
import SwiftUI

// MARK: - Feature Item Button

struct FeatureItemButton: View {
    let item: FeatureItem
    
    var body: some View {
        Button(action: item.action) {
            HStack(spacing: 12) {
                // Icon
                Text(item.icon)
                    .font(.title3)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemGray6))
                    .cornerRadius(6)
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor( .primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Arrow
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
