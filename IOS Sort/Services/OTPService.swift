//
//  OTPService.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

class OTPService: ObservableObject {
    static let shared = OTPService()
    
    @Published var currentOTP: String = ""
    @Published var phoneNumber: String = ""
    @Published var isOTPValid: Bool = false
    @Published var attemptsRemaining: Int = 3
    @Published var lastMessageSID: String = ""
    
    private var otpExpirationTime: Date?
    private let otpValidityMinutes: TimeInterval = 5 // OTP valid for 5 minutes
    private let twilioService = TwilioService.shared
    
    private init() {}
    
    // MARK: - OTP Generation
    
    func generateOTP(for phoneNumber: String) async -> String {
        self.phoneNumber = phoneNumber
        self.currentOTP = generateRandomOTP()
        self.otpExpirationTime = Date().addingTimeInterval(otpValidityMinutes * 60)
        self.isOTPValid = false
        self.attemptsRemaining = 3
        
        // Send OTP via Twilio if configured, otherwise use demo mode
        if twilioService.validateConfiguration() {
            do {
                let messageSID = try await twilioService.sendOTP(to: phoneNumber, otpCode: currentOTP)
                self.lastMessageSID = messageSID
                print("📱 OTP sent via Twilio to \(phoneNumber): \(currentOTP) (SID: \(messageSID))")
            } catch {
                print("❌ Failed to send OTP via Twilio: \(error.localizedDescription)")
                print("📱 Demo OTP for \(phoneNumber): \(currentOTP)")
            }
        } else {
            print("📱 Demo OTP for \(phoneNumber): \(currentOTP)")
        }
        
        return currentOTP
    }
    
    private func generateRandomOTP() -> String {
        let digits = "0123456789"
        return String((0..<4).map { _ in digits.randomElement()! })
    }
    
    // MARK: - OTP Validation
    
    func verifyOTP(_ inputOTP: String) -> OTPVerificationResult {
        guard !currentOTP.isEmpty else {
            return .error("No OTP generated. Please request a new code.")
        }
        
        guard let expirationTime = otpExpirationTime else {
            return .error("OTP has expired. Please request a new code.")
        }
        
        guard Date() < expirationTime else {
            return .error("OTP has expired. Please request a new code.")
        }
        
        guard attemptsRemaining > 0 else {
            return .error("Too many failed attempts. Please request a new code.")
        }
        
        if inputOTP == currentOTP {
            isOTPValid = true
            return .success("OTP verified successfully!")
        } else {
            attemptsRemaining -= 1
            let remainingText = attemptsRemaining > 0 ? " \(attemptsRemaining) attempts remaining." : ""
            return .error("Invalid OTP.\(remainingText)")
        }
    }
    
    // MARK: - OTP Management
    
    func resendOTP() async -> String {
        guard !phoneNumber.isEmpty else {
            return ""
        }
        return await generateOTP(for: phoneNumber)
    }
    
    func clearOTP() {
        currentOTP = ""
        phoneNumber = ""
        isOTPValid = false
        otpExpirationTime = nil
        attemptsRemaining = 3
    }
    
    func isOTPExpired() -> Bool {
        guard let expirationTime = otpExpirationTime else { return true }
        return Date() >= expirationTime
    }
    
    func getTimeRemaining() -> TimeInterval {
        guard let expirationTime = otpExpirationTime else { return 0 }
        return max(0, expirationTime.timeIntervalSinceNow)
    }
    
    // MARK: - Phone Number Validation
    
    func validatePhoneNumber(_ phoneNumber: String) -> PhoneValidationResult {
        let cleanedNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard !cleanedNumber.isEmpty else {
            return .error("Phone number cannot be empty")
        }
        
        guard cleanedNumber.count >= 10 else {
            return .error("Phone number must be at least 10 digits")
        }
        
        guard cleanedNumber.count <= 15 else {
            return .error("Phone number cannot exceed 15 digits")
        }
        
        // Check for valid patterns
        let patterns = [
            "^1[0-9]{10}$", // US/Canada format
            "^[2-9][0-9]{9}$", // US format without country code
            "^\\+[1-9][0-9]{1,14}$" // International format
        ]
        
        let isValidPattern = patterns.contains { pattern in
            cleanedNumber.range(of: pattern, options: .regularExpression) != nil
        }
        
        if isValidPattern {
            return .success(cleanedNumber)
        } else {
            return .error("Invalid phone number format")
        }
    }
}

// MARK: - Result Types

enum OTPVerificationResult {
    case success(String)
    case error(String)
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .error:
            return false
        }
    }
    
    var message: String {
        switch self {
        case .success(let message), .error(let message):
            return message
        }
    }
}

enum PhoneValidationResult {
    case success(String)
    case error(String)
    
    var isValid: Bool {
        switch self {
        case .success:
            return true
        case .error:
            return false
        }
    }
    
    var message: String {
        switch self {
        case .success(let message), .error(let message):
            return message
        }
    }
    
    var cleanedNumber: String {
        switch self {
        case .success(let number):
            return number
        case .error:
            return ""
        }
    }
}
