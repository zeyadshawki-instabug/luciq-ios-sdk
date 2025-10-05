//
//  InfoPage.swift
//  NewSampleLuciqSwiftUI
//
//  Created by zeyad Shawki on 29/09/2025.
//

import SwiftUI
import LuciqSDK
import SafariServices

struct InfoPage: View {
    @State private var showingDashboard = false
    @State private var showingDocs = false
    @State private var showingContact = false
    
    var body: some View {
        LuciqTracedView(name: "Info Screen") {
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Section
                        VStack(spacing: 16) {
                            Image("LuciqLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                                .foregroundColor(.appPrimary)
                            
                            Text("Luciq SDK")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("Comprehensive App Monitoring & User Feedback Platform")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 20)
                        
                        // Overview Section
                        InfoSection(
                            title: "What is Luciq?",
                            content: "Luciq is a comprehensive app monitoring and user feedback platform designed to help developers build better mobile applications. It provides real-time insights into app performance, user behavior, and feedback collection, enabling teams to make data-driven decisions and improve user experience.",
                            icon: "info.circle",
                            color: .blue
                        )
                        
                        // Key Benefits Section
                        InfoSection(
                            title: "Why Choose Luciq?",
                            content: "• Real-time performance monitoring\n• Comprehensive crash reporting\n• User feedback collection\n• Advanced analytics and insights\n• Easy integration with minimal code\n• Privacy-focused data collection\n• Support for both iOS and Android platforms",
                            icon: "star.circle",
                            color: .orange
                        )
                        
                        // Features Overview Section
                        InfoSection(
                            title: "Core Features",
                            content: "Luciq offers a complete suite of tools including:\n• Bug Reporting with screenshots and context\n• Crash Reporting with automatic detection\n• App Performance Monitoring (APM)\n• Session Replay for debugging\n• In-App Replies and chat\n• In-App Surveys and NPS\n• Feature Requests collection\n• User identification and custom data\n• Network monitoring and analytics",
                            icon: "gear",
                            color: .green
                        )
                        
                        // Technical Benefits Section
                        InfoSection(
                            title: "Technical Advantages",
                            content: "• Minimal performance impact\n• Automatic crash detection and reporting\n• Network request monitoring\n• Memory and CPU usage tracking\n• Custom event tracking\n• Offline data collection\n• Secure data transmission",
                            icon: "wrench.and.screwdriver",
                            color: .purple
                        )
                        
                        // iOS Specific Features Section
                        InfoSection(
                            title: "iOS Platform Support",
                            content: "Luciq SDK for iOS supports both UIKit and SwiftUI frameworks:\n• Repro Steps with auto-masking\n• User Steps tracking\n• Current View in Occurrences\n• Private Views support\n• SwiftUI Integration (Automatic)\n• Comprehensive iOS documentation\n• iOS 15.0+ support",
                            icon: "iphone",
                            color: .indigo
                        )
                        
                        // Integration Section
                        InfoSection(
                            title: "Easy Integration",
                            content: "Luciq SDK can be integrated into your iOS app in just a few steps:\n1. Add the SDK to your project via CocoaPods or Swift Package Manager\n2. Configure your API key in AppDelegate or App struct\n3. Start collecting valuable insights about your app's performance\n4. Access detailed documentation at docs.luciq.ai",
                            icon: "plus.circle",
                            color: .red
                        )
                   
                    }
                    .padding()
                    
                    // Action Buttons Section
                    VStack(spacing: 12) {
                        Button(action: {
                            showingDashboard = true
                        }) {
                            HStack {
                                Image(systemName: "chart.bar.fill")
                                    .font(.title3)
                                Text("Open Luciq Dashboard")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            showingDocs = true
                        }) {
                            HStack {
                                Image(systemName: "book.fill")
                                    .font(.title3)
                                Text("Open Luciq iOS Docs")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            showingContact = true
                        }) {
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .font(.title3)
                                Text("Contact Us")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("About Luciq")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $showingDashboard) {
            SafariView(url: URL(string: Configuration.dashboardURL)!)
        }
        .sheet(isPresented: $showingDocs) {
            SafariView(url: URL(string: Configuration.documentationURL)!)
        }
        .sheet(isPresented: $showingContact) {
            ContactUsView()
        }
    }
}

// MARK: - Safari View
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // No updates needed
    }
}

// MARK: - Contact Us View
struct ContactUsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 16) {
                    Image(systemName: "envelope.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Text("Contact Us")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Get in touch with our team")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Contact Information
                VStack(spacing: 16) {
                    ContactInfoRow(
                        icon: "globe",
                        title: "Website",
                        value: "luciq.ai",
                        action: {
                            if let url = URL(string: Configuration.websiteURL) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                    
                    ContactInfoRow(
                        icon: "doc.text",
                        title: "Documentation",
                        value: "docs.luciq.ai",
                        action: {
                            if let url = URL(string: Configuration.documentationURL) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                    
                    ContactInfoRow(
                        icon: "chart.bar",
                        title: "Dashboard",
                        value: "dashboard.luciq.ai",
                        action: {
                            if let url = URL(string: Configuration.dashboardURL) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                    
                    ContactInfoRow(
                        icon: "questionmark.circle",
                        title: "Support",
                        value: "support@luciq.ai",
                        action: {
                            if let url = URL(string: "mailto:\(Configuration.supportEmail)") {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Contact")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// MARK: - Contact Info Row
struct ContactInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 30)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview

#Preview {
    InfoPage()
}
