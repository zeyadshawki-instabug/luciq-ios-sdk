//
//  Configuration.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 29/09/2025.
//

import Foundation
import LuciqSDK
/**
 # Luciq Configuration
 
 Centralized configuration for all Luciq SDK tokens and settings.
 This file contains all the necessary tokens and configuration values
 used throughout the application.
 
 ## Usage:
 - Import this file in any view or service that needs Luciq tokens
 - Use the static properties to access tokens and configuration
 - Update tokens in one place for the entire application
 */
struct Configuration {
    
    // MARK: - App Token
    
    /// The main Luciq SDK app token
    /// Replace this with your actual app token from the Luciq dashboard
    static var appToken = "d824b0efb5573e97ac7c03fb03d2d0a3"
    
    // MARK: - Survey Tokens
    
    /// NPS Survey token
    /// Replace with your actual NPS survey token from the Luciq dashboard
    static var npsSurveyToken = ""
    
    /// Multi-Question Survey token
    /// Replace with your actual multi-question survey token from the Luciq dashboard
    static var multiQuestionSurveyToken = ""
    
    // MARK: - SDK Configuration
    
    /// Default user ID for testing
    static let defaultUserID = "user123"
    
    /// Default user email for testing
    static let defaultUserEmail = "JohnDoe@example.com"
    
    /// Default user name for testing
    static let defaultUserName = "John Doe"
    
    // MARK: - Feature Flags
    
    /// Default feature flag for testing
    static let defaultFeatureFlag = FeatureFlag(name: "new_feature", variant: "enabled")
    
    // MARK: - Tags
    
    /// Default tags for testing
    static let defaultTags = ["iOS", "SwiftUI", "Demo", "Testing"]
}
