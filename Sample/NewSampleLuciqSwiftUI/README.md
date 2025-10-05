# NewSampleLuciqSwiftUI

A comprehensive SwiftUI demo application showcasing all Luciq SDK features with a modern tab-based interface.

## Overview

This sample app demonstrates the full capabilities of the Luciq SDK through an intuitive SwiftUI interface. It includes all major Luciq features, detailed information about the SDK, and performance monitoring capabilities.

## Features

### 🏠 Home Tab
- **Show Luciq**: Opens the main Luciq dashboard
- **Show Intro Message**: Displays welcome message with beta theme
- **Crash Me**: Tests crash reporting functionality
- **Show NPS Survey**: Launches NPS survey (requires token)
- **Show Multi Question Survey**: Launches multi-question survey (requires token)
- **Show Feature Requests**: Opens feature requests interface
- **Settings**: Access to SDK configuration options

### ⭐ Features Tab
Detailed overview of all Luciq SDK capabilities:
- **Bug Reporting**: User-friendly bug reporting with screenshots and context
- **Crash Reporting**: Automatic crash detection and reporting
- **Performance Monitoring**: Real-time app performance metrics
- **User Surveys**: NPS and custom survey creation
- **Feature Requests**: User feedback and feature request management
- **Analytics & Insights**: Comprehensive app analytics
- **Network Monitoring**: API and network request tracking
- **Custom Events**: Flexible event tracking and user journey mapping

### ℹ️ Info Tab
Comprehensive information about the Luciq SDK:
- SDK overview and benefits
- Technical advantages
- Integration guidance
- Key features explanation

### 📊 Performance Tab
Real-time performance monitoring:
- SDK initialization time
- Memory usage tracking
- Disk usage monitoring
- CPU usage metrics

## Architecture

The app is built using SwiftUI with a clean, modular architecture:

- **SharedComponents.swift**: Reusable UI components
- **HomePage.swift**: Main feature showcase with interactive cards
- **InfoPage.swift**: SDK information and benefits
- **FeaturesPage.swift**: Detailed feature descriptions with expandable cards
- **PerformancePage.swift**: Real-time performance monitoring
- **ContentView.swift**: Tab-based navigation structure

## Key Components

### FeatureCard
Interactive cards for each Luciq feature with:
- Custom icons and colors
- Feature descriptions
- Action handling

### InfoSection
Informational sections with:
- Icons and titles
- Detailed content
- Consistent styling

### PerformanceRow & MonitoringCard
Performance monitoring components with:
- Real-time data display
- Progress indicators
- Color-coded metrics

## Integration

This sample app demonstrates how to integrate Luciq SDK into a SwiftUI application:

1. Import `LuciqSDK` in your views
2. Use `LuciqTracedView` for automatic view tracking
3. Call Luciq methods for different features
4. Configure surveys with appropriate tokens

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- Luciq SDK

## Getting Started

1. Ensure Luciq SDK is properly integrated
2. Configure your survey tokens in `HomePage.swift`
3. Build and run the project
4. Explore different tabs to see all features

## Customization

The app uses a consistent design system with:
- Custom colors defined in `SharedComponents.swift`
- Reusable components for consistent UI
- Easy-to-modify feature configurations
- Extensible architecture for new features
