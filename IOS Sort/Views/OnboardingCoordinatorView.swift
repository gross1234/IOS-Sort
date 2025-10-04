//
//  OnboardingCoordinatorView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var showingOnboarding = true
    
    var body: some View {
        Group {
            if showingOnboarding {
                OnboardingFlowView(viewModel: viewModel)
                    .onAppear {
                        checkOnboardingStatus()
                    }
            } else {
                // Main app content
                ContentView()
            }
        }
    }
    
    private func checkOnboardingStatus() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
        if hasCompletedOnboarding {
            showingOnboarding = false
        }
    }
}

struct OnboardingFlowView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            // Background
            Color.white
                .ignoresSafeArea()
            
            // Content based on current step
            switch viewModel.currentStep {
            case .interests:
                InterestSelectionView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                
            case .profile:
                ProfileSetupView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                
            case .login:
                LoginSignupView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                
            case .otpVerification:
                OTPVerificationView(viewModel: viewModel)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                
            case .completed:
                OnboardingCompleteView(viewModel: viewModel)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
    }
}

struct OnboardingCompleteView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showingMainApp = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Success animation
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                }
                
                Text("Welcome to Sort!")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                Text("You're all set!")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Continue button
            Button(action: {
                withAnimation {
                    showingMainApp = true
                }
            }) {
                Text("Get Started")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showingMainApp) {
            ContentView()
        }
    }
}

// MARK: - Onboarding Progress Indicator

struct OnboardingProgressView: View {
    let currentStep: OnboardingStep
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(OnboardingStep.allCases.dropLast(), id: \.self) { step in
                Circle()
                    .fill(step.rawValue <= currentStep.rawValue ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    OnboardingCoordinatorView()
}
