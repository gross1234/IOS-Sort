//
//  OTPVerificationView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct OTPVerificationView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var otpDigits: [String] = Array(repeating: "", count: 4)
    @FocusState private var focusedField: Int?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    viewModel.previousStep()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            // Illustration Section
            VStack(spacing: 30) {
                // Phone with map illustration
                ZStack {
                    // Background circles
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(Color.blue.opacity(0.1))
                            .frame(width: CGFloat(80 + index * 20))
                            .offset(
                                x: CGFloat.random(in: -30...30),
                                y: CGFloat.random(in: -20...20)
                            )
                    }
                    
                    // Phone illustration
                    VStack(spacing: 8) {
                        // Phone body
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black)
                            .frame(width: 120, height: 200)
                            .overlay(
                                // Screen
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(width: 100, height: 160)
                                    .overlay(
                                        // Map on screen
                                        VStack(spacing: 4) {
                                            // Map lines
                                            ForEach(0..<4, id: \.self) { _ in
                                                Rectangle()
                                                    .fill(Color.gray.opacity(0.3))
                                                    .frame(height: 2)
                                            }
                                            
                                            // Location pin
                                            VStack(spacing: 0) {
                                                Image(systemName: "mappin.circle.fill")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.red)
                                                
                                                Circle()
                                                    .fill(Color.yellow)
                                                    .frame(width: 8, height: 8)
                                            }
                                            .offset(y: -10)
                                        }
                                    )
                            )
                        
                        // Finger pointing
                        Image(systemName: "hand.point.up.left.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.orange)
                            .offset(x: 40, y: -50)
                    }
                }
                .frame(height: 200)
            }
            .padding(.vertical, 40)
            
            // Form Section
            VStack(spacing: 24) {
                // Title
                Text("OTP Verification")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                // Subtitle
                Text("Enter the OTP sent to your mobile number")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // OTP Input Fields
                HStack(spacing: 12) {
                    ForEach(0..<4, id: \.self) { index in
                        TextField("", text: $otpDigits[index])
                            .textFieldStyle(OTPTextFieldStyle())
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: index)
                            .onChange(of: otpDigits[index]) { newValue in
                                // Limit to single digit
                                if newValue.count > 1 {
                                    otpDigits[index] = String(newValue.prefix(1))
                                }
                                
                                // Move to next field
                                if !newValue.isEmpty && index < 3 {
                                    focusedField = index + 1
                                }
                                
                                // Update view model
                                viewModel.otpCode = otpDigits.joined()
                            }
                            .onChange(of: focusedField) { newValue in
                                if newValue == index && otpDigits[index].isEmpty {
                                    // Clear field when focused
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
                
                // Resend Code
                HStack {
                    Spacer()
                    
                    if viewModel.canResendOTP {
                        Button("Resend Code") {
                            viewModel.resendOTP()
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    } else {
                        Text("Resend Code in \(viewModel.otpTimer)s")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                
                // Continue Button
                Button(action: {
                    Task {
                        await viewModel.verifyOTP()
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        
                        Text(viewModel.isLoading ? "Verifying..." : "Continue")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(viewModel.validateCurrentStep() ? Color.gray.opacity(0.8) : Color.gray.opacity(0.3))
                    .cornerRadius(12)
                }
                .disabled(!viewModel.validateCurrentStep() || viewModel.isLoading)
                .padding(.horizontal, 20)
                
                // Error message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .background(Color.white)
        }
        .background(Color.white)
        .onAppear {
            focusedField = 0
        }
    }
}

struct OTPTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 24, weight: .bold))
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

#Preview {
    OTPVerificationView(viewModel: OnboardingViewModel())
}
