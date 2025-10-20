//
//  NetworkService.swift
//  NewSampleLuciqSwiftUI
//
//  Copyright © 2025 Luciq. All rights reserved.
//

import Foundation
import LuciqSDK

/// NetworkService handles network requests with NSURLSession and integrates with Luciq network logging
class NetworkService: NSObject {
    static let shared = NetworkService()
    
    // MARK: - Properties
    
    private var currentTask: URLSessionDataTask?
    private var session: URLSession!
    private var downloadProgress: ((Double) -> Void)?
    
    // MARK: - Configuration
    
    private override init() {
        super.init()
        configureSession(with: createDefaultConfiguration())
    }
    
    /// Creates a default URL session configuration with network logging enabled
    private func createDefaultConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        // Enable Luciq network logging for this configuration
        NetworkLogger.enableLogging(for: configuration)
        
        return configuration
    }
    
    /// Enable network logging globally
    static func enableNetworkLogging() {
        NetworkLogger.enabled = true
    }
    
    /// Disable network logging globally
    static func disableNetworkLogging() {
        NetworkLogger.enabled = false
    }
    
    /// Configures the session with a specific configuration
    func configureSession(with configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - Network Requests
    
    /// Performs a simple GET request
    func performGetRequest(url: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let requestURL = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("LuciqDemo/1.0", forHTTPHeaderField: "User-Agent")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        
        task.resume()
    }
    
    /// Performs a large request that can be cancelled
    func performLargeRequest(url: String, progressHandler: @escaping (Double) -> Void, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let requestURL = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        self.downloadProgress = progressHandler
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                if (error as NSError).code == NSURLErrorCancelled {
                    completion(.failure(NetworkError.cancelled))
                } else {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        currentTask = task
        task.resume()
    }
    
    /// Cancels the current large request
    func cancelCurrentRequest() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    // MARK: - Test Requests
    
    /// Test GET request to JSONPlaceholder
    func testSimpleGetRequest(completion: @escaping (Result<String, Error>) -> Void) {
        performGetRequest(url: "https://jsonplaceholder.typicode.com/posts/1", completion: completion)
    }
    
    /// Test GET request with query parameters
    func testGetRequestWithParams(completion: @escaping (Result<String, Error>) -> Void) {
        performGetRequest(url: "https://jsonplaceholder.typicode.com/posts?userId=1", completion: completion)
    }
    
    /// Test large file download (10MB test file)
    func testLargeFileDownload(progressHandler: @escaping (Double) -> Void, completion: @escaping (Result<Data, Error>) -> Void) {
        // Using a sample large file URL for testing
        performLargeRequest(url: "https://jsonplaceholder.typicode.com/photos", progressHandler: progressHandler, completion: completion)
    }
    
    /// Test multiple sequential requests
    func testMultipleRequests(completion: @escaping (Result<[String], Error>) -> Void) {
        let urls = [
            "https://jsonplaceholder.typicode.com/posts/1",
            "https://jsonplaceholder.typicode.com/posts/2",
            "https://jsonplaceholder.typicode.com/posts/3"
        ]
        
        var results: [String] = []
        let dispatchGroup = DispatchGroup()
        var error: Error?
        
        for url in urls {
            dispatchGroup.enter()
            performGetRequest(url: url) { result in
                switch result {
                case .success(let data):
                    results.append(data)
                case .failure(let err):
                    error = err
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(results))
            }
        }
    }
    
    /// Test failed request (404 error)
    func testFailedRequest(completion: @escaping (Result<String, Error>) -> Void) {
        performGetRequest(url: "https://jsonplaceholder.typicode.com/posts/999999", completion: completion)
    }
    
    /// Test timeout request
    func testTimeoutRequest(completion: @escaping (Result<String, Error>) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 0.1 // Very short timeout
        NetworkLogger.enableLogging(for: configuration)
        
        let tempSession = URLSession(configuration: configuration)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = tempSession.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NetworkError.noData))
            }
        }
        
        task.resume()
    }
}

// MARK: - URLSessionDelegate

extension NetworkService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let expectedContentLength = dataTask.response?.expectedContentLength, expectedContentLength > 0 {
            let progress = Double(dataTask.countOfBytesReceived) / Double(expectedContentLength)
            DispatchQueue.main.async {
                self.downloadProgress?(progress)
            }
        }
    }
}

// MARK: - Network Errors

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case cancelled
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingFailed:
            return "Failed to decode response"
        case .cancelled:
            return "Request was cancelled"
        }
    }
}

// MARK: - Network Configuration Manager

class NetworkConfigurationManager {
    static let shared = NetworkConfigurationManager()
    
    private init() {}
    
    /// Enable network logging
    func enableNetworkLogging() {
        NetworkLogger.enabled = true
    }
    
    /// Disable network logging
    func disableNetworkLogging() {
        NetworkLogger.enabled = false
    }
    
    /// Set request obfuscation handler to hide sensitive data
    func setRequestObfuscation() {
        NetworkLogger.setRequestObfuscationHandler { request in
            var mutableRequest = request
            
            // Obfuscate authorization headers
            if var headers = mutableRequest.allHTTPHeaderFields {
                if headers["Authorization"] != nil {
                    headers["Authorization"] = "***REDACTED***"
                }
                mutableRequest.allHTTPHeaderFields = headers
            }
            
            return mutableRequest
        }
    }
    
    /// Set response obfuscation handler to hide sensitive response data
    func setResponseObfuscation() {
        NetworkLogger.setResponseObfuscationHandler { responseData, response, returnBlock in
            guard let data = responseData,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                returnBlock(responseData, response)
                return
            }
            
            var mutableJson = jsonObject
            
            // Obfuscate sensitive fields
            if mutableJson["password"] != nil {
                mutableJson["password"] = "***REDACTED***"
            }
            if mutableJson["token"] != nil {
                mutableJson["token"] = "***REDACTED***"
            }
            
            if let obfuscatedData = try? JSONSerialization.data(withJSONObject: mutableJson, options: []) {
                returnBlock(obfuscatedData, response)
            } else {
                returnBlock(responseData, response)
            }
        }
    }
    
    /// Set network logging filters to exclude certain requests
    func setNetworkFilters() {
        // Filter out requests to specific domains
        let requestPredicate = NSPredicate(format: "url.host CONTAINS[cd] %@", "example-analytics.com")
        
        // Filter out successful responses (only log errors)
        let responsePredicate = NSPredicate(format: "statusCode >= 400")
        
        NetworkLogger.setNetworkLoggingRequestFilterPredicate(requestPredicate, responseFilterPredicate: responsePredicate)
    }
    
    /// Clear network filters
    func clearNetworkFilters() {
        NetworkLogger.setNetworkLoggingRequestFilterPredicate(nil, responseFilterPredicate: nil)
    }
    
    /// Configure custom session with network logging
    func createCustomConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.httpAdditionalHeaders = [
            "X-Custom-Header": "LuciqDemo",
            "Accept": "application/json"
        ]
        
        NetworkLogger.enableLogging(for: config)
        
        return config
    }
}

