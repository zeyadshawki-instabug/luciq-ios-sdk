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
                            
                            Text("Fix nothing Build something  that matters. Let developers build boldly with mobile observability that doesn’t just watch but works. Intelligent agents detect, diagnose, and resolve issues before users notice, so your team ships confidently and your app just works.")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 20)
                    }
                    .padding()
                    
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
                    .padding(.horizontal)
                }
                .navigationTitle("About Luciq")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .sheet(isPresented: $showingContact) {
            ContactUsView()
        }
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
                            
                            if let url = URL(string: "https://luciq.ai") {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                    
                    ContactInfoRow(
                        icon: "doc.text",
                        title: "Documentation",
                        value: "docs.luciq.ai",
                        action: {
                            if let url = URL(string: "https://docs.luciq.ai/docs/ios-overview") {
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
