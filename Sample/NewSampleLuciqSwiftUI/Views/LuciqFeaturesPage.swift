//
//  LuciqFeaturesPage.swift
//  LuciqSwiftUIDemo
//
//  Copyright © 2025 Luciq. All rights reserved.
//

import SwiftUI
import LuciqSDK

 /*
 ## Documentation:
 For complete API documentation, visit: https://docs.luciq.ai/docs/ios-integration
 */

struct LuciqFeaturesPage: View {
    
    // MARK: - Token Management State
    @State private var showingAppTokenAlert = false
    @State private var showingNPSTokenAlert = false
    @State private var showingMultiQuestionTokenAlert = false
    @State private var changeAppTokenText = ""
    @State private var changeNpsTokenText = ""
    @State private var changeMultiQuestionTokenText = ""
    
    // MARK: - Network Testing State
    @State private var networkStatus: String = "Ready"
    @State private var showingNetworkAlert = false
    @State private var downloadProgress: Double = 0.0
    @State private var isDownloading = false
        
    // MARK: - Feature Data
    
    private var featureCategories: [FeatureCategoryData] {
        [
            // Core SDK
            FeatureCategoryData(category: .core, items: [
                FeatureItem(title: "Change App Token", description: "Update the main Luciq SDK app token", icon: "🔑") {
                    changeAppTokenText = Configuration.appToken
                    showingAppTokenAlert = true
                },
                FeatureItem(title: "Start Luciq SDK", description: "Initialize the SDK with token and invocation events", icon: "🚀") {
                    Luciq.start(withToken: Configuration.appToken, invocationEvents:[.shake, .floatingButton])
                },
                FeatureItem(title: "Show Luciq", description: "Show Luciq", icon: "👁️") {
                    Luciq.show()
                },
                FeatureItem(title: "Show Welcome Message", description: "Display welcome message to users", icon: "👋") {
                    Luciq.showWelcomeMessage(with: .beta)
                },
                FeatureItem(title: "Stop luciq",description:"Stop Luciq", icon: "❌") {
                    Luciq.enabled = false
                },
            ]),
            
            // User Management
            FeatureCategoryData(category: .userManagement, items: [
                FeatureItem(title: "Identify User", description: "Set user ID, email, and name", icon: "🔍") {
                    /// Identifies the current user with ID and email and name
                    Luciq.identifyUser(withID: Configuration.defaultUserID, email: Configuration.defaultUserEmail, name: Configuration.defaultUserName)
                },
                FeatureItem(title: "Logout User", description: "Clear current user session", icon: "🚪") {
                    /// Resets the value of the user's email and name, previously set
                    Luciq.logOut()
                },
                FeatureItem(title: "Set User Data", description: "Attach custom data to reports", icon: "📝") {
                    /// Sets user data for reports
                    Luciq.userData = "User is on iOS 18.0, using iPhone 15 Pro"
                }
            ]),
            
            // Bug Reporting
            FeatureCategoryData(category: .bugReporting, items: [
                FeatureItem(title: "Report Bug", description: "Show bug reporting interface", icon: "🐛") {
                    // Shows the compose view of a bug report
                    BugReporting.show(with: .bug, options: [.commentFieldRequired,.emailFieldOptional])
                },
                FeatureItem(title: "Suggest Improvement", description: "Show feedback interface", icon: "💡") {
                    // Shows the compose view of a feedback
                    BugReporting.show(with: .feedback, options: [])
                },
                FeatureItem(title: "Configure Bug Reporting", description: "Set up bug reporting options", icon: "🔧") {
                    // Change prompt options enabled for report types
                    BugReporting.promptOptionsEnabledReportTypes = [.bug, .feedback, .question]
                },
                FeatureItem(title: "Add File Attachment", description: "Attach a file to reports", icon: "📄") {
                    // Create a example file
                    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    let fileURL = documentsPath.appendingPathComponent("example_text.txt")
                    let sampleText = "This is a example file attachment for Luciq"
                    try? sampleText.write(to: fileURL, atomically: true, encoding: .utf8)
                    
                    // Add the example file attachment
                    Luciq.addFileAttachment(with: fileURL)
                },
                FeatureItem(title: "Add Data Attachment", description: "Attach data to reports", icon: "💾") {
                    // Create a example data
                    let sampleData = "Sample data attachment".data(using: .utf8)!
                    
                    // Add the example data attachment
                    Luciq.addFileAttachment(with: sampleData, andName: "example_data.txt")
                },
                FeatureItem(title: "Clear Attachments", description: "Remove all file attachments", icon: "🗑️") {
                    Luciq.clearFileAttachments()
                }
            ]),
            
            // Performance Monitoring
            FeatureCategoryData(category: .apm, items: [
                FeatureItem(title: "Start APM Flow", description: "Begin tracking user flow", icon: "▶️") {
                    // Starts a new "Sample User Flow" APM flow
                    APM.startFlow(withName: "Sample User Flow")
                },
                FeatureItem(title: "Add Attribute For Flow", description: "Begin tracking user flow", icon: "📝") {
                    // Add custom attributes to an existing flow
                    APM.setAttributeForFlowWithName("Sample User Flow", key: "attribute-key", value: "attribute-value")
                },
                FeatureItem(title: "End APM Flow", description: "Complete user flow tracking", icon: "⏹️") {
                    // Ends the "Sample User Flow" APM flow
                    APM.endFlow(withName: "Sample User Flow")
                },
                FeatureItem(title: "Start UI Trace", description: "Begin UI performance trace", icon: "▶️") {
                    // Starts a Custom UI Trace with the given name.
                    APM.startUITrace(withName: "Sample UI Trace")
                },
                FeatureItem(title: "End UI Trace", description: "Complete UI performance trace", icon: "⏹️") {
                    // Ends the current running Custom UI Trace.
                    APM.endUITrace()
                },
                FeatureItem(title: "End App Launch", description: "Mark app launch completion", icon: "🛑") {
                    //  In the event that you'd like to define a specific point in time where the app launch can be considered complete, such as when the app is actually interactable, you can use the end app launch API to set that point. You'll then be able to see this data alongside the automatic cold and hot app launches that were captured.
                    
                    // To use the End App Launch API, you'll just need to call the following method:
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
                FeatureItem(title: "Change NPS Survey Token", description: "Update the NPS survey token", icon: "🔑") {
                    changeNpsTokenText = Configuration.npsSurveyToken
                    showingNPSTokenAlert = true
                },
                FeatureItem(title: "Change Multi-Question Survey Token", description: "Update the multi-question survey token", icon: "🔑") {
                    changeMultiQuestionTokenText = Configuration.multiQuestionSurveyToken
                    showingMultiQuestionTokenAlert = true
                },
            ]),
            
            // Feature Flags
            FeatureCategoryData(category: .featureFlags, items: [
                FeatureItem(title: "Set User Attribute", description: "Set custom user attributes", icon: "🏷️") {
                    // Set custom user attributes that are going to be sent with each feedback, bug or crash.
                    Luciq.setUserAttribute("Premium", withKey: "subscription_type")
                    Luciq.setUserAttribute("iOS", withKey: "platform")
                },
                FeatureItem(title: "Add Feature Flag", description: "Add a feature flag", icon: "➕") {
                    // Add a single Feature flag
                    Luciq.add(featureFlag: Configuration.defaultFeatureFlag)
                },
                FeatureItem(title: "Remove Feature Flag", description: "Remove a feature flag", icon: "➖") {
                    // Remove added Feature flag.
                    Luciq.removeFeatureFlag(Configuration.defaultFeatureFlag.name)
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
                    // Appends a set of tags to previously added tags of reported feedback, bug or crash.
                    Luciq.appendTags(Configuration.defaultTags)
                },
                FeatureItem(title: "Reset Tags", description: "Clear all tags", icon: "🔄") {
                    // Manually removes all tags of reported feedback, bug or crash.
                    Luciq.resetTags()
                },
                FeatureItem(title: "Get Tags", description: "View current tags", icon: "👀") {
                    // Gets all tags of reported feedback, bug or crash.
                    let tags = Luciq.getTags()
                    print("Tags: \(tags)")
                }
            ]),
            
            // Network Testing
            FeatureCategoryData(category: .networking, items: [
                FeatureItem(title: "Enable Network Logging", description: "Enable network request logging", icon: "📡") {
                    NetworkConfigurationManager.shared.enableNetworkLogging()
                    networkStatus = "Network logging enabled"
                },
                FeatureItem(title: "Disable Network Logging", description: "Disable network request logging", icon: "🚫") {
                    NetworkConfigurationManager.shared.disableNetworkLogging()
                    networkStatus = "Network logging disabled"
                },
                FeatureItem(title: "Simple GET Request", description: "Test basic GET request", icon: "📥") {
                    testSimpleGetRequest()
                },
                FeatureItem(title: "GET with Parameters", description: "Test GET request with query params", icon: "🔗") {
                    testGetRequestWithParams()
                },
                FeatureItem(title: "Test Auto-Cancel Request", description: "Start download and auto-cancel after 1 sec", icon: "⏱️") {
                    testAutoCancelRequest()
                },
                FeatureItem(title: "Multiple Requests", description: "Test sequential requests", icon: "🔄") {
                    testMultipleRequests()
                },
                FeatureItem(title: "Test Failed Request", description: "Trigger 404 error", icon: "❌") {
                    testFailedRequest()
                },
                FeatureItem(title: "Test Timeout", description: "Trigger request timeout", icon: "⏱️") {
                    testTimeoutRequest()
                },
                FeatureItem(title: "Set Request Obfuscation", description: "Hide sensitive request data", icon: "🔒") {
                    NetworkConfigurationManager.shared.setRequestObfuscation()
                    networkStatus = "Request obfuscation enabled"
                },
                FeatureItem(title: "Set Response Obfuscation", description: "Hide sensitive response data", icon: "🛡️") {
                    NetworkConfigurationManager.shared.setResponseObfuscation()
                    networkStatus = "Response obfuscation enabled"
                },
                FeatureItem(title: "Set Network Filters", description: "Filter network logs", icon: "🔍") {
                    NetworkConfigurationManager.shared.setNetworkFilters()
                    networkStatus = "Network filters applied"
                },
                FeatureItem(title: "Clear Network Filters", description: "Remove all filters", icon: "🗑️") {
                    NetworkConfigurationManager.shared.clearNetworkFilters()
                    networkStatus = "Network filters cleared"
                },
                FeatureItem(title: "Custom Configuration", description: "Use custom session config", icon: "⚙️") {
                    let customConfig = NetworkConfigurationManager.shared.createCustomConfiguration()
                    NetworkService.shared.configureSession(with: customConfig)
                    networkStatus = "Custom configuration applied"
                }
            ]),
            
            // Testing & Debugging
            FeatureCategoryData(category: .testing, items: [
                FeatureItem(title: "Crash Me", description: "Trigger a crash for testing", icon: "💥") {
                    crashMe()
                },
                FeatureItem(title: "Capture Screenshot", description: "Take a screenshot", icon: "📸") {
                    Luciq.captureScreenshot()
                },
                FeatureItem(title: "Log User Event", description: "Log a custom user event", icon: "📝") {
                    Luciq.logUserEvent(withName: "Sample User Event")
                },
                FeatureItem(title: "Set Debug Level", description: "Configure debug logging", icon: "🔍") {
                    // Set SDK debug logs level
                    Luciq.sdkDebugLogsLevel = .verbose
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
                            // Network Status Card
                            if !networkStatus.isEmpty && networkStatus != "Ready" {
                                VStack(spacing: 8) {
                                    Text("Network Status")
                                        .font(.headline)
                                    Text(networkStatus)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.center)
                                    
                                    if isDownloading {
                                        ProgressView(value: downloadProgress)
                                            .progressViewStyle(.linear)
                                            .padding(.horizontal)
                                        Text("\(Int(downloadProgress * 100))%")
                                            .font(.caption)
                                    }
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                                .padding(.horizontal)
                            }
                            
                            // Feature Categories
                            ForEach(featureCategories) { categoryData in
                                FeatureCategoryView(
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
        .alert("Change App Token", isPresented: $showingAppTokenAlert) {
            TextField("App Token", text: $changeAppTokenText)
            Button("Cancel", role: .cancel) { }
            Button("Update") {
                updateAppToken(newToken: changeAppTokenText)
            }
        } message: {
            Text("Enter the new Luciq SDK app token.")
        }
        .alert("Change NPS Survey Token", isPresented: $showingNPSTokenAlert) {
            TextField("NPS Survey Token", text: $changeNpsTokenText)
            Button("Cancel", role: .cancel) { }
            Button("Update") {
                updateNPSToken(newToken: changeNpsTokenText)
            }
        } message: {
            Text("Enter the new NPS survey token. This will be used for NPS surveys.")
        }
        .alert("Change Multi-Question Survey Token", isPresented: $showingMultiQuestionTokenAlert) {
            TextField("Multi-Question Survey Token", text: $changeMultiQuestionTokenText)
            Button("Cancel", role: .cancel) { }
            Button("Update") {
                updateMultiQuestionToken(newToken: changeMultiQuestionTokenText)
            }
        } message: {
            Text("Enter the new multi-question survey token. This will be used for multi-question surveys.")
        }
        .alert("Network Result", isPresented: $showingNetworkAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(networkStatus)
        }
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
   
   // MARK: - UI SDK Customization Implementation
   
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
      
   // MARK: - Additional Advanced Features

   /// Updates the app token and restarts the SDK
   private func updateAppToken(newToken: String) {
       // Update Configuration
       Configuration.appToken = newToken
       Luciq.start(withToken: Configuration.appToken, invocationEvents: [.floatingButton])
   }
   
   /// Updates the NPS survey token
   private func updateNPSToken(newToken: String) {
       // Update Configuration
       Configuration.npsSurveyToken = newToken
       Surveys.showSurvey(withToken: Configuration.npsSurveyToken)
   }
   
   /// Updates the multi-question survey token
   private func updateMultiQuestionToken(newToken: String) {
       // Update Configuration
       Configuration.multiQuestionSurveyToken = newToken
       Surveys.showSurvey(withToken: Configuration.multiQuestionSurveyToken)
   }
   
   // MARK: - Network Testing Methods
   
   /// Test simple GET request
   private func testSimpleGetRequest() {
       networkStatus = "Loading simple GET request..."
       NetworkService.shared.testSimpleGetRequest { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let data):
                   networkStatus = "✅ GET request successful!\nReceived \(data.count) characters"
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "❌ GET request failed: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       }
   }
   
   /// Test GET request with parameters
   private func testGetRequestWithParams() {
       networkStatus = "Loading GET request with params..."
       NetworkService.shared.testGetRequestWithParams { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let data):
                   networkStatus = "✅ GET with params successful!\nReceived \(data.count) characters"
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "❌ GET with params failed: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       }
   }
   
   /// Test auto-cancel request: starts download and cancels after 1 second
   private func testAutoCancelRequest() {
       isDownloading = true
       downloadProgress = 0.0
       networkStatus = "Starting download...\nWill auto-cancel in 1 second"
       
       NetworkService.shared.testLargeFileDownload(progressHandler: { progress in
           DispatchQueue.main.async {
               self.downloadProgress = progress
               self.networkStatus = "Downloading... \(Int(progress * 100))%\nCancelling in 1 second"
           }
       }, completion: { result in
           DispatchQueue.main.async {
               self.isDownloading = false
               switch result {
               case .success(let data):
                   networkStatus = "⚠️ Download completed before cancel\nReceived \(ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file))"
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "✅ Request cancelled successfully!\nError: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       })
       
       // Auto-cancel after 1 second
//       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
           NetworkService.shared.cancelCurrentRequest()
           self.networkStatus = "⏱️ Cancelling request..."
//       }
   }
   
   /// Test multiple sequential requests
   private func testMultipleRequests() {
       networkStatus = "Loading multiple requests..."
       NetworkService.shared.testMultipleRequests { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let responses):
                   networkStatus = "✅ Multiple requests successful!\nCompleted \(responses.count) requests"
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "❌ Multiple requests failed: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       }
   }
   
   /// Test failed request (404)
   private func testFailedRequest() {
       networkStatus = "Testing failed request..."
       NetworkService.shared.testFailedRequest { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let data):
                   networkStatus = "✅ Request completed (unexpected success)\nReceived: \(data.prefix(100))..."
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "✅ Request failed as expected: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       }
   }
   
   /// Test timeout request
   private func testTimeoutRequest() {
       networkStatus = "Testing timeout..."
       NetworkService.shared.testTimeoutRequest { result in
           DispatchQueue.main.async {
               switch result {
               case .success(let data):
                   networkStatus = "⚠️ Request completed (no timeout)\nReceived: \(data.prefix(100))..."
                   showingNetworkAlert = true
               case .failure(let error):
                   networkStatus = "✅ Timeout occurred: \(error.localizedDescription)"
                   showingNetworkAlert = true
               }
           }
       }
   }
}

// MARK: - Preview

#Preview {
   LuciqFeaturesPage()
}
