//
//  OnboardingViewModel.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation
import SwiftUI

@MainActor
class OnboardingViewModel: ObservableObject {
    @Published var currentStep: OnboardingStep = .phoneNumber
    @Published var onboardingData = OnboardingData()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // OTP Service
    private let otpService = OTPService.shared
    
    // Interest selection
    @Published var interests = EventInterest.allInterests
    
    // Profile setup
    @Published var profile = UserProfile()
    @Published var selectedProfileImage: UIImage?
    
    // Login
    @Published var phoneNumber = ""
    @Published var countryCode = "+1"
    
    // OTP Verification
    @Published var otpCode = ""
    @Published var otpTimer = 60
    @Published var canResendOTP = false
    
    private var otpTimerTask: Task<Void, Never>?
    
    init() {
        startOTPTimer()
    }
    
    deinit {
        otpTimerTask?.cancel()
    }
    
    // MARK: - Navigation
    
    func nextStep() {
        guard let nextStep = OnboardingStep(rawValue: currentStep.rawValue + 1) else {
            completeOnboarding()
            return
        }
        currentStep = nextStep
    }
    
    func previousStep() {
        guard let previousStep = OnboardingStep(rawValue: currentStep.rawValue - 1) else { return }
        currentStep = previousStep
    }
    
    func skipToMainApp() {
        completeOnboarding()
    }
    
    private func completeOnboarding() {
        currentStep = .completed
        onboardingData.isLoggedIn = true
        // Here you would typically save to UserDefaults or send to server
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
    }
    
    // MARK: - Interest Selection
    
    func toggleInterest(_ interest: EventInterest) {
        if let index = interests.firstIndex(where: { $0.id == interest.id }) {
            interests[index].isSelected.toggle()
        }
    }
    
    func getSelectedInterests() -> [EventInterest] {
        return interests.filter { $0.isSelected }
    }
    
    func canProceedFromInterests() -> Bool {
        return getSelectedInterests().count >= 3 // Minimum 3 interests required
    }
    
    // MARK: - Profile Setup
    
    func updateProfile() {
        onboardingData.profile = profile
    }
    
    func canProceedFromProfile() -> Bool {
        return !profile.username.isEmpty
    }
    
    // MARK: - Phone Number
    
    func sendOTP() async {
        isLoading = true
        errorMessage = nil
        
        // Validate phone number first
        let validationResult = otpService.validatePhoneNumber(phoneNumber)
        
        if !validationResult.isValid {
            isLoading = false
            errorMessage = validationResult.message
            return
        }
        
        // Simulate API call delay
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // Generate real OTP
        let generatedOTP = await otpService.generateOTP(for: validationResult.cleanedNumber)
        
        isLoading = false
        
        // In a real app, you would send this OTP via SMS/email
        // For demo purposes, we'll show it in console and proceed
        print("📱 OTP sent to \(phoneNumber): \(generatedOTP)")
        
        nextStep()
    }
    
    func canProceedFromPhone() -> Bool {
        return otpService.validatePhoneNumber(phoneNumber).isValid
    }
    
    // MARK: - OTP Verification
    
    func verifyOTP() async {
        isLoading = true
        errorMessage = nil
        
        // Simulate API call delay
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // Verify OTP using the service
        let verificationResult = otpService.verifyOTP(otpCode)
        
        isLoading = false
        
        if verificationResult.isSuccess {
            nextStep()
        } else {
            errorMessage = verificationResult.message
        }
    }
    
    func resendOTP() async {
        let newOTP = await otpService.resendOTP()
        otpCode = ""
        otpTimer = 60
        canResendOTP = false
        startOTPTimer()
        
        print("📱 New OTP sent to \(phoneNumber): \(newOTP)")
    }
    
    private func startOTPTimer() {
        otpTimerTask?.cancel()
        otpTimerTask = Task {
            while otpTimer > 0 {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
                if !Task.isCancelled {
                    otpTimer -= 1
                }
            }
            canResendOTP = true
        }
    }
    
    // MARK: - Validation
    
    func validateCurrentStep() -> Bool {
        switch currentStep {
        case .phoneNumber:
            return canProceedFromPhone()
        case .otpVerification:
            return otpCode.count == 4
        case .profile:
            return canProceedFromProfile()
        case .decision:
            return true // Always can proceed from decision
        case .completed:
            return true
        }
    }
}
