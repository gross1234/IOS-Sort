//
//  TwilioConfig.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

struct TwilioConfig {
    // MARK: - Twilio Credentials
    // Replace these with your actual Twilio credentials
    
    static let accountSID = "YOUR_TWILIO_ACCOUNT_SID"
    static let authToken = "YOUR_TWILIO_AUTH_TOKEN"
    static let fromPhoneNumber = "YOUR_TWILIO_PHONE_NUMBER" // Format: +1234567890
    
    // MARK: - Configuration
    
    static var isConfigured: Bool {
        return !accountSID.isEmpty && 
               !authToken.isEmpty && 
               !fromPhoneNumber.isEmpty &&
               accountSID != "YOUR_TWILIO_ACCOUNT_SID" &&
               authToken != "YOUR_TWILIO_AUTH_TOKEN" &&
               fromPhoneNumber != "YOUR_TWILIO_PHONE_NUMBER"
    }
    
    static var configurationStatus: String {
        if isConfigured {
            return "✅ Twilio configured and ready"
        } else {
            return "⚠️ Twilio not configured - using demo mode"
        }
    }
    
    // MARK: - Environment Variables (Alternative)
    // You can also use environment variables for security
    
    static var accountSIDFromEnv: String {
        return ProcessInfo.processInfo.environment["TWILIO_ACCOUNT_SID"] ?? accountSID
    }
    
    static var authTokenFromEnv: String {
        return ProcessInfo.processInfo.environment["TWILIO_AUTH_TOKEN"] ?? authToken
    }
    
    static var fromPhoneNumberFromEnv: String {
        return ProcessInfo.processInfo.environment["TWILIO_PHONE_NUMBER"] ?? fromPhoneNumber
    }
}
