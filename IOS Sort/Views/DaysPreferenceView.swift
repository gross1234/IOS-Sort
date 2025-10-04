//
//  DaysPreferenceView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct DaysPreferenceView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var dayPreferences: [String: Double] = [
        "Mondays": -7,
        "Tuesday": -7,
        "Wednesday": -7,
        "Thursday": -7,
        "Fridays": -7,
        "Saturdays": -7,
        "Sundays": -7
    ]
    
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
            
            // Title and subtitle
            VStack(spacing: 16) {
                Text("What days work best")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Personalize your feed to see more events you love and less of what you don't.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
            
            // Days with sliders
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(Array(dayPreferences.keys.sorted()), id: \.self) { day in
                        DaySliderView(
                            day: day,
                            value: $dayPreferences[day] ?? -7
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100) // Space for continue button
            }
            
            // Continue button
            VStack {
                Button(action: {
                    viewModel.nextStep()
                }) {
                    Text("Continue")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

struct DaySliderView: View {
    let day: String
    @Binding var value: Double
    
    var body: some View {
        VStack(spacing: 12) {
            // Day name
            Text(day)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Single slider
            VStack(spacing: 8) {
                SingleSlider(
                    value: $value,
                    bounds: -7...7,
                    step: 1
                )
                
                // Scale labels
                HStack {
                    ForEach([-7, -5, -3, 3, 5, 7], id: \.self) { scaleValue in
                        Text("\(Int(scaleValue))")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        
                        if scaleValue != 7 {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct SingleSlider: View {
    @Binding var value: Double
    let bounds: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        GeometryReader { geometry in
            let boundsWidth = bounds.upperBound - bounds.lowerBound
            let valueOffset = value - bounds.lowerBound
            let thumbPosition = valueOffset * geometry.size.width / boundsWidth
            let activeWidth = valueOffset * geometry.size.width / boundsWidth
            
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(height: 4)
                    .cornerRadius(2)
                
                // Active range (from start to current value)
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 4)
                    .cornerRadius(2)
                    .frame(width: activeWidth)
                
                // Thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .offset(x: thumbPosition - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { dragValue in
                                let newValue = bounds.lowerBound + (dragValue.location.x / geometry.size.width) * boundsWidth
                                let clampedValue = max(bounds.lowerBound, min(newValue, bounds.upperBound))
                                value = clampedValue
                            }
                    )
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    DaysPreferenceView(viewModel: OnboardingViewModel())
}
