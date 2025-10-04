//
//  TwilioService.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

class TwilioService: ObservableObject {
    static let shared = TwilioService()
    
    // Twilio Configuration
    private let accountSID = TwilioConfig.accountSIDFromEnv
    private let authToken = TwilioConfig.authTokenFromEnv
    private let fromPhoneNumber = TwilioConfig.fromPhoneNumberFromEnv
    
    private init() {}
    
    // MARK: - SMS Sending
    
    func sendSMS(to phoneNumber: String, message: String) async throws -> String {
        let url = URL(string: "https://api.twilio.com/2010-04-01/Accounts/\(accountSID)/Messages.json")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Basic Authentication
        let credentials = "\(accountSID):\(authToken)"
        let base64Credentials = Data(credentials.utf8).base64EncodedString()
        request.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        // Request body
        let body = "From=\(fromPhoneNumber)&To=\(phoneNumber)&Body=\(message)"
        request.httpBody = body.data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw TwilioError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw TwilioError.apiError(errorMessage)
        }
        
        // Parse response to get message SID
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
           let messageSID = json["sid"] as? String {
            return messageSID
        }
        
        throw TwilioError.invalidResponse
    }
    
    // MARK: - OTP SMS
    
    func sendOTP(to phoneNumber: String, otpCode: String) async throws -> String {
        let message = "Your Sort verification code is: \(otpCode). This code expires in 5 minutes."
        return try await sendSMS(to: phoneNumber, message: message)
    }
    
    // MARK: - Configuration Validation
    
    func validateConfiguration() -> Bool {
        return TwilioConfig.isConfigured
    }
    
    func getConfigurationStatus() -> String {
        return TwilioConfig.configurationStatus
    }
}

// MARK: - Twilio Errors

enum TwilioError: Error, LocalizedError {
    case invalidResponse
    case apiError(String)
    case configurationError
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from Twilio API"
        case .apiError(let message):
            return "Twilio API Error: \(message)"
        case .configurationError:
            return "Twilio configuration is missing or invalid"
        case .networkError:
            return "Network error occurred"
        }
    }
}
