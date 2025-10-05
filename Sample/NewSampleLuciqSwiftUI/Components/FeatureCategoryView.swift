//
//  FeatureCategoryView.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation
import SwiftUI

// MARK: - Feature Category View

struct FeatureCategoryView: View {
    let category: FeatureCategory
    let items: [FeatureItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Category Header
            HStack {
                Text(category.icon)
                    .font(.title2)
                Text(category.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(.systemGray5))
            .cornerRadius(8)
            
            // Feature Items
            VStack(spacing: 8) {
                ForEach(items) { item in
                    FeatureItemButton(item: item)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
