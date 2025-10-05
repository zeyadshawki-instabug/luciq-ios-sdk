//
//  LuciqFeaturesPage.swift
//  LuciqSwiftUIDemo
//
//  Copyright © 2025 Luciq. All rights reserved.
//

import SwiftUI
import LuciqSDK

/**
 # Luciq SDK Comprehensive Feature Demo
 
 This page demonstrates all the major features and capabilities of the Luciq SDK for iOS.
 The features are organized in the order they should typically be implemented in a real application.
 
 ## Why We Have All These Features:
 
 ### 1. **Core SDK Initialization** 🚀
 - `Luciq.startWithToken` - The first and most important method to call
 - This initializes the entire SDK and must be called before any other Luciq methods
 - Sets up the foundation for all other features
 
 ### 2. **User Management** 👤
 - User identification and authentication
 - User data attachment to reports
 - User logout functionality
 - Essential for personalized support and debugging
 
 ### 3. **Bug Reporting** 🐛
 - Core functionality for collecting user feedback and bug reports
 - Multiple report types (bugs, feedback, feature requests)
 - Advanced options like attachments, screen recording, and extended forms
 - Critical for app quality improvement
 
 ### 4. **Application Performance Monitoring (APM)** 📊
 - Real-time performance tracking
 - Flow monitoring for user journeys
 - UI trace analysis
 - App launch time tracking
 - Essential for performance optimization
 
 ### 5. **File Attachments** 📎
 - Attach files and data to reports
 - Support for various file types
 - Helps provide context for bug reports
 - Useful for debugging complex issues
 
 ### 6. **User Attributes & Feature Flags** 🏷️
 - Track user characteristics and app features
 - A/B testing and feature rollouts
 - Better segmentation and analysis
 - Modern app development best practices
 
 ### 7. **UI Customization** 🎨
 - Branding and theming
 - Custom fonts and colors
 - Consistent user experience
 - Professional appearance
 
 ### 8. **Tags and Experiments** 🧪
 - Categorize and filter reports
 - Track experimental features
 - Better organization and analysis
 - Historical tracking capabilities
 
 ### 9. **Testing & Debugging** 🔧
 - Crash testing and reporting
 - Screenshot capture
 - User event logging
 - Debug level configuration
 - Essential for development and testing
 
 ### 10. **Survey Features** 📋
 - User feedback collection
 - NPS surveys
 - Feature request management
 - User satisfaction tracking
 
 ## Implementation Order:
 1. Start with `Luciq.startWithToken` in your AppDelegate/SceneDelegate
 2. Configure basic settings (theme, user identification)
 3. Set up bug reporting options
 4. Enable APM for performance monitoring
 5. Add advanced features as needed
 
 ## Documentation:
 For complete API documentation, visit: https://docs.luciq.ai/docs/ios-integration
 */

struct LuciqFeaturesPage: View {
    
    // MARK: - Feature Categories
    
     enum FeatureCategory: String, CaseIterable, Identifiable {
        case core = "Luciq SDK"
        case userManagement = "User Management"
        case bugReporting = "Bug Reporting"
        case apm = "Performance Monitoring"
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
    
    // MARK: - Feature Items
    
     struct FeatureItem: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let action: () -> Void
        let isDestructive: Bool
        let icon: String
        
        init(title: String, description: String, icon: String = "⚡", isDestructive: Bool = false, action: @escaping () -> Void) {
            self.title = title
            self.description = description
            self.icon = icon
            self.isDestructive = isDestructive
            self.action = action
        }
    }
    
    // MARK: - Feature Category Data
    
    private struct FeatureCategoryData: Identifiable {
        let id = UUID()
        let category: FeatureCategory
        let items: [FeatureItem]
    }
    
    // MARK: - Feature Data
    
    private var featureCategories: [FeatureCategoryData] {
        [
            // Core SDK
            FeatureCategoryData(category: .core, items: [
                FeatureItem(title: "Start Luciq SDK", description: "Initialize the SDK with token and invocation events", icon: "🚀") {
                    startLuciqSDK()
                },
                FeatureItem(title: "Show Luciq", description: "Display the Luciq interface", icon: "👁️") {
                    Luciq.show()
                },
                FeatureItem(title: "Show Welcome Message", description: "Display welcome message to users", icon: "👋") {
                    Luciq.showWelcomeMessage(with: .beta)
                },
                FeatureItem(title: "Stop luciq",description:"Stop Luciq", icon: "❌") {
                    startLuciqSDK()
                },
            ]),
            
            // User Management
            FeatureCategoryData(category: .userManagement, items: [
                FeatureItem(title: "Identify User", description: "Set user ID, email, and name", icon: "🔍") {
                    identifyUser()
                },
                FeatureItem(title: "Logout User", description: "Clear current user session", icon: "🚪") {
                    Luciq.logOut()
                },
                FeatureItem(title: "Set User Data", description: "Attach custom data to reports", icon: "📝") {
                    setUserData()
                }
            ]),
            
            // Bug Reporting
            FeatureCategoryData(category: .bugReporting, items: [
                FeatureItem(title: "Report Bug", description: "Show bug reporting interface", icon: "🐛") {
                    BugReporting.show(with: .bug, options: [])
                },
                FeatureItem(title: "Suggest Improvement", description: "Show feedback interface", icon: "💡") {
                    BugReporting.show(with: .feedback, options: [])
                },
                FeatureItem(title: "Bug Report with Options", description: "Show bug report with custom options", icon: "⚙️") {
                    BugReporting.show(with: .bug, options: [.emailFieldHidden, .commentFieldRequired])
                },
                FeatureItem(title: "Configure Bug Reporting", description: "Set up bug reporting options", icon: "🔧") {
                    configureBugReporting()
                },
                FeatureItem(title: "Add File Attachment", description: "Attach a file to reports", icon: "📄") {
                    addFileAttachment()
                },
                FeatureItem(title: "Add Data Attachment", description: "Attach data to reports", icon: "💾") {
                    addDataAttachment()
                },
                FeatureItem(title: "Clear Attachments", description: "Remove all file attachments", icon: "🗑️") {
                    Luciq.clearFileAttachments()
                }
            ]),
            
            // Performance Monitoring
            FeatureCategoryData(category: .apm, items: [
                FeatureItem(title: "Start APM Flow", description: "Begin tracking user flow", icon: "▶️") {
                    startAPMFlow()
                },
                FeatureItem(title: "End APM Flow", description: "Complete user flow tracking", icon: "⏹️") {
                    endAPMFlow()
                },
                FeatureItem(title: "Start UI Trace", description: "Begin UI performance trace", icon: "📱") {
                    startUITrace()
                },
                FeatureItem(title: "End UI Trace", description: "Complete UI performance trace", icon: "✅") {
                    APM.endUITrace()
                },
                FeatureItem(title: "End App Launch", description: "Mark app launch completion", icon: "🚀") {
                    APM.endAppLaunch()
                }
            ]),
            
            // Surveys & Feedback
            FeatureCategoryData(category: .surveys, items: [
                FeatureItem(title: "Show NPS Survey", description: "Display Net Promoter Score survey", icon: "⭐") {
                    Surveys.showSurvey(withToken: Configuration.npsSurveyToken)
                },
                FeatureItem(title: "Show Multi-Question Survey", description: "Display comprehensive survey", icon: "📝") {
                    Surveys.showSurvey(withToken: Configuration.multiQuestionSurveyToken)
                },
                FeatureItem(title: "Show Feature Requests", description: "Display feature request interface", icon: "💭") {
                    FeatureRequests.show()
                },
            ]),
            
            // Feature Flags
            FeatureCategoryData(category: .featureFlags, items: [
                FeatureItem(title: "Set User Attribute", description: "Set custom user attributes", icon: "🏷️") {
                    setUserAttribute()
                },
                FeatureItem(title: "Add Feature Flag", description: "Add a feature flag", icon: "➕") {
                    addFeatureFlag()
                },
                FeatureItem(title: "Remove Feature Flag", description: "Remove a feature flag", icon: "➖") {
                    removeFeatureFlag()
                }
            ]),
            
            // UI Customization
            FeatureCategoryData(category: .Customization, items: [
                FeatureItem(title: "Set Custom Theme", description: "Apply custom UI theme", icon: "🎨") {
                    setCustomTheme()
                },
                FeatureItem(title: "Set Custom Font", description: "Apply custom font", icon: "🔤") {
                    setCustomFont()
                },
            ]),
            
            // Tags & Experiments
            FeatureCategoryData(category: .tags, items: [
                FeatureItem(title: "Add Tags", description: "Add tags to reports", icon: "🏷️") {
                    addTags()
                },
                FeatureItem(title: "Reset Tags", description: "Clear all tags", icon: "🔄") {
                    Luciq.resetTags()
                },
                FeatureItem(title: "Get Tags", description: "View current tags", icon: "👀") {
                    getTags()
                }
            ]),
            
            // Testing & Debugging
            FeatureCategoryData(category: .testing, items: [
                FeatureItem(title: "Crash Me", description: "Trigger a crash for testing", icon: "💥", isDestructive: true) {
                    crashMe()
                },
                FeatureItem(title: "Capture Screenshot", description: "Take a screenshot", icon: "📸") {
                    Luciq.captureScreenshot()
                },
                FeatureItem(title: "Log User Event", description: "Log a custom user event", icon: "📝") {
                    Luciq.logUserEvent(withName: "Sample User Event")
                },
                FeatureItem(title: "Set Debug Level", description: "Configure debug logging", icon: "🔍") {
                    setDebugLevel()
                }
            ])
        ]
    }
   
    // MARK: - View
    
    var body: some View {
        LuciqTracedView(name: "Luciq Features Demo") {
            NavigationView {
                ZStack {
                    Color.background.ignoresSafeArea()
                    
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            // Header
                            
                            // Feature Categories
                            ForEach(featureCategories) { categoryData in
                                FeatureCategorySection(
                                    category: categoryData.category,
                                    items: categoryData.items
                                )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Luciq SDK Features")
            }
        }
    }
}

// MARK: - Feature Category Section

struct FeatureCategorySection: View {
    let category: LuciqFeaturesPage.FeatureCategory
    let items: [LuciqFeaturesPage.FeatureItem]
    
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

// MARK: - Feature Item Button

struct FeatureItemButton: View {
    let item: LuciqFeaturesPage.FeatureItem
    
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
                        .foregroundColor(item.isDestructive ? .red : .primary)
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

// MARK: - Private Methods

private extension LuciqFeaturesPage {
  
   
   /// Intentionally triggers a fatal error to test crash reporting functionality.
   private func crashMe() {
       let array: [Int] = []
       // This will cause a fatal error: Index out of range.
       _ = array[0]
   }
   
   // MARK: - Core Luciq Features Implementation
   
   /// Starts the Luciq SDK with token and invocation events
   private func startLuciqSDK() {
       Luciq.sdkDebugLogsLevel = .verbose
       Luciq.start(withToken: Configuration.appToken, invocationEvents:[.shake, .floatingButton])
    }
    
    /// Stop  the Luciq SDK with token and invocation events
    private func stopLuciqSDK() {
        Luciq.enabled = false
     }
    
   // MARK: - User Management Implementation
   
   /// Identifies the current user with email and name
   private func identifyUser() {
       Luciq.identifyUser(withID: Configuration.defaultUserID, email: Configuration.defaultUserEmail, name: Configuration.defaultUserName)
   }
   
   /// Sets user data for reports
   private func setUserData() {
       Luciq.userData = "User is on iOS 18.0, using iPhone 15 Pro"
   }
   
   // MARK: - Bug Reporting Implementation
   
   /// Configures bug reporting options
   private func configureBugReporting() {
       // Enable bug reporting
       BugReporting.enabled = true
       BugReporting.promptOptionsEnabledReportTypes = [.bug, .feedback, .question]
   }
   
   // MARK: - APM Implementation
   
   /// Starts an APM flow
   private func startAPMFlow() {
       APM.startFlow(withName: "Sample User Flow")
   }
   
   /// Ends the current APM flow
   private func endAPMFlow() {
       APM.endFlow(withName: "Sample User Flow")
   }
   
   /// Starts a UI trace
   private func startUITrace() {
       APM.startUITrace(withName: "Sample UI Trace")
   }
   
   // MARK: - File Attachments Implementation
   
   /// Adds a file attachment
   private func addFileAttachment() {
       // Create a sample text file
       let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       let fileURL = documentsPath.appendingPathComponent("sample.txt")
       
       let sampleText = "This is a sample file attachment for Luciq"
       try? sampleText.write(to: fileURL, atomically: true, encoding: .utf8)
       
       Luciq.addFileAttachment(with: fileURL)
   }
   
   /// Adds a data attachment
   private func addDataAttachment() {
       let sampleData = "Sample data attachment".data(using: .utf8)!
       Luciq.addFileAttachment(with: sampleData, andName: "sample_data.txt")
   }
   
   // MARK: - User Attributes & Feature Flags Implementation
   
   /// Sets a user attribute
   private func setUserAttribute() {
       Luciq.setUserAttribute("Premium", withKey: "subscription_type")
       Luciq.setUserAttribute("iOS", withKey: "platform")
   }
   
   /// Adds a feature flag
   private func addFeatureFlag() {
       Luciq.add(featureFlag: Configuration.defaultFeatureFlag)
   }
   
   /// Removes a feature flag
   private func removeFeatureFlag() {
       Luciq.removeFeatureFlag(Configuration.defaultFeatureFlag.name)
   }
   
   // MARK: - UI Customization Implementation
   
   /// Sets a custom theme
   private func setCustomTheme() {
       let theme = Theme()
       theme.primaryColor = UIColor.yellow //  Color of UI elements that indicate interactivity (Links, or Call To Action)
       theme.backgroundColor = UIColor.systemGray

       theme.titleTextColor = UIColor.systemGreen
       theme.subtitleTextColor = UIColor.systemCyan

       theme.primaryTextColor = UIColor.systemBlue
       theme.secondaryTextColor = UIColor.blue
       theme.callToActionTextColor = UIColor.cyan

       theme.headerBackgroundColor = UIColor.systemBrown
       theme.footerBackgroundColor = UIColor.systemTeal
       theme.rowBackgroundColor = UIColor.systemPink
       theme.selectedRowBackgroundColor = UIColor.systemBrown

       let menlo = UIFont(name: "menlo", size: 10)!
       theme.primaryTextFont = menlo
       theme.secondaryTextFont = menlo
       theme.callToActionTextFont = menlo

       theme.rowSeparatorColor = UIColor.systemGreen

       Luciq.theme = theme
   }
   
   /// Sets a custom font
   private func setCustomFont() {
       if let customFont = UIFont(name: "Arial", size: 16) {
           Luciq.font = customFont
       }
   }
    
    /// Sets a custom font
    private func setLocale() {
        Luciq.setLocale(.french)
    }
    
   // MARK: - Tags Implementation
   
   /// Adds tags to reports
   private func addTags() {
       Luciq.appendTags(Configuration.defaultTags)
   }
   
   /// Gets current tags
   private func getTags() {
       let tags = Luciq.getTags()
       print("Tags: \(tags)")
   }
   
   // MARK: - Debugging Implementation
   
   /// Sets debug level
   private func setDebugLevel() {
       Luciq.sdkDebugLogsLevel = .verbose
   }
   
   // MARK: - Additional Advanced Features
   
   /// Demonstrates session profiler configuration
   private func configureSessionProfiler() {
       Luciq.sessionProfilerEnabled = true
   }
   
   /// Demonstrates CoreData instrumentation
   private func configureCoreDataInstrumentation() {
       Luciq.coreDataInstrumentationEnabled = true
   }
   
   /// Demonstrates user steps tracking
   private func configureUserStepsTracking() {
       Luciq.trackUserSteps = true
       Luciq.swizzleOnSwiftUIInteractions = true
   }
   
   /// Demonstrates welcome message configuration
   private func configureWelcomeMessage() {
       Luciq.welcomeMessageMode = .beta
   }
   
   /// Demonstrates color theme setting
   private func setColorTheme() {
       Luciq.setColorTheme(.light)
   }
   
   /// Demonstrates string Customization
   private func customizeStrings() {
       Luciq.setValue("Custom Bug Report", forStringWithKey: "LCQShakeStartAlertTextStringName")
   }
   
   /// Demonstrates user consent for bug reports
   private func addUserConsent() {
       BugReporting.addUserConsent(
           withKey: "privacy_consent",
           description: "I agree to share my data for debugging purposes",
           mandatory: true,
           checked: false
       )
   }
   
   /// Demonstrates proactive reporting configuration
   private func configureProactiveReporting() {
       let config = ProactiveReportingConfigurations()
       // Configure proactive reporting settings here
       BugReporting.setProactiveReportingConfigurations(config)
   }
}

// MARK: - Preview

#Preview {
   LuciqFeaturesPage()
}
