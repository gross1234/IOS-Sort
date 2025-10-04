//
//  InterestSelectionView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct InterestSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedCount = 0
    
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
            
            Spacer()
            
            // Filter Icon
            VStack(spacing: 20) {
                // Custom Filter Icon
                ZStack {
                    // Blue top part
                    Image(systemName: "triangle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(180))
                        .offset(y: -20)
                    
                    // Red bottom part
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 60, height: 80)
                        .cornerRadius(8)
                        .offset(y: 20)
                }
                .frame(height: 120)
            }
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: 16) {
                Button(action: {
                    viewModel.nextStep()
                }) {
                    Text("Choose event interests takes 5 min")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(25)
                }
                .disabled(!viewModel.canProceedFromInterests())
                
                Button(action: {
                    viewModel.skipToLogin()
                }) {
                    Text("Skip onboarding")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(Color.white)
        .onAppear {
            selectedCount = viewModel.getSelectedInterests().count
        }
        .onChange(of: viewModel.interests) { _ in
            selectedCount = viewModel.getSelectedInterests().count
        }
    }
}

#Preview {
    InterestSelectionView(viewModel: OnboardingViewModel())
}
