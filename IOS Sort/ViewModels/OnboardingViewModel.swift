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
        
        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        
        // In a real app, you would call your API here
        // For demo purposes, we'll just proceed
        isLoading = false
        nextStep()
    }
    
    func canProceedFromPhone() -> Bool {
        return phoneNumber.count >= 10 // Basic phone number validation
    }
    
    // MARK: - OTP Verification
    
    func verifyOTP() async {
        isLoading = true
        errorMessage = nil
        
        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 second delay
        
        // In a real app, you would verify the OTP with your backend
        if otpCode == "1234" || otpCode.count == 4 { // Demo validation
            isLoading = false
            nextStep()
        } else {
            isLoading = false
            errorMessage = "Invalid OTP. Please try again."
        }
    }
    
    func resendOTP() {
        otpCode = ""
        otpTimer = 60
        canResendOTP = false
        startOTPTimer()
        
        // In a real app, you would call your API to resend OTP
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
        case .interests:
            return canProceedFromInterests()
        case .decision:
            return true // Always can proceed from decision
        case .profile:
            return canProceedFromProfile()
        case .completed:
            return true
        }
    }
}
