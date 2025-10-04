//
//  LoginSignupView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct LoginSignupView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showingCountryPicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Illustration Section
            VStack(spacing: 0) {
                // Background with illustration
                ZStack {
                    Color.blue.opacity(0.1)
                        .frame(height: 300)
                    
                    // Illustration elements
                    VStack(spacing: 20) {
                        // Table and people
                        ZStack {
                            // Table
                            Rectangle()
                                .fill(Color.brown.opacity(0.3))
                                .frame(width: 200, height: 20)
                                .cornerRadius(4)
                            
                            // People
                            HStack(spacing: 60) {
                                // Person 1
                                VStack {
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 30, height: 30)
                                    Rectangle()
                                        .fill(Color.yellow)
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(8)
                                }
                                
                                // Person 2
                                VStack {
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 30, height: 30)
                                    Rectangle()
                                        .fill(Color.blue)
                                        .frame(width: 40, height: 60)
                                        .cornerRadius(8)
                                }
                            }
                            .offset(y: -20)
                        }
                        
                        // Floating elements
                        HStack(spacing: 30) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 20))
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 20))
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.orange)
                                .font(.system(size: 20))
                        }
                        .offset(y: -40)
                    }
                }
            }
            
            // Login Form Section
            VStack(spacing: 24) {
                // Title
                Text("User Login / Sign up")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 30)
                
                // Legal text
                Text("by continuing you agree to Sort's terms & conditions and privacy policy")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Phone number input
                HStack(spacing: 12) {
                    // Country code picker
                    Button(action: {
                        showingCountryPicker = true
                    }) {
                        HStack(spacing: 8) {
                            Text("🇺🇸")
                                .font(.system(size: 20))
                            Text(viewModel.countryCode)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 16)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                    
                    // Phone number field
                    TextField("Enter your phone number", text: $viewModel.phoneNumber)
                        .textFieldStyle(PlainTextFieldStyle())
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                
                // Continue button
                Button(action: {
                    Task {
                        await viewModel.sendOTP()
                    }
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        
                        Text(viewModel.isLoading ? "Sending..." : "Continue")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(viewModel.canProceedFromLogin() ? Color.blue : Color.gray)
                    .cornerRadius(12)
                }
                .disabled(!viewModel.canProceedFromLogin() || viewModel.isLoading)
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
        .sheet(isPresented: $showingCountryPicker) {
            CountryCodePicker(selectedCode: $viewModel.countryCode)
        }
    }
}

struct CountryCodePicker: View {
    @Binding var selectedCode: String
    @Environment(\.dismiss) private var dismiss
    
    let countryCodes = [
        ("🇺🇸", "+1", "United States"),
        ("🇨🇦", "+1", "Canada"),
        ("🇬🇧", "+44", "United Kingdom"),
        ("🇦🇺", "+61", "Australia"),
        ("🇩🇪", "+49", "Germany"),
        ("🇫🇷", "+33", "France"),
        ("🇯🇵", "+81", "Japan"),
        ("🇨🇳", "+86", "China"),
        ("🇮🇳", "+91", "India"),
        ("🇧🇷", "+55", "Brazil")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(countryCodes, id: \.1) { flag, code, country in
                    Button(action: {
                        selectedCode = code
                        dismiss()
                    }) {
                        HStack {
                            Text(flag)
                                .font(.system(size: 24))
                            Text(code)
                                .font(.system(size: 16, weight: .medium))
                            Text(country)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Spacer()
                            if selectedCode == code {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .foregroundColor(.black)
                }
            }
            .navigationTitle("Select Country")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginSignupView(viewModel: OnboardingViewModel())
}
