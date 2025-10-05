//
//  FeatureCategoryData.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 05/10/2025.
//

import Foundation

struct FeatureCategoryData: Identifiable {
    let id = UUID()
    let category: FeatureCategory
    let items: [FeatureItem]
}
