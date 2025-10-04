//
//  CategoriesSelectionView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct CategoriesSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var trainersRange: ClosedRange<Double> = -3...3
    @State private var activitiesRange: ClosedRange<Double> = -3...3
    @State private var communityEventsRange: ClosedRange<Double> = -3...3
    @State private var socializingRange: ClosedRange<Double> = -3...3
    @State private var thrillSeekingRange: ClosedRange<Double> = -3...3
    @State private var churchRange: ClosedRange<Double> = -3...3
    
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
                Text("Choose Categories!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Personalize your feed to see more events love and less of what you don't.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
            
            // Categories with sliders
            ScrollView {
                VStack(spacing: 24) {
                    CategorySliderView(title: "Trainers", range: $trainersRange)
                    CategorySliderView(title: "Activities", range: $activitiesRange)
                    CategorySliderView(title: "Community events", range: $communityEventsRange)
                    CategorySliderView(title: "Socializing", range: $socializingRange)
                    CategorySliderView(title: "Thrill seeking", range: $thrillSeekingRange)
                    CategorySliderView(title: "Church", range: $churchRange)
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

struct CategorySliderView: View {
    let title: String
    @Binding var range: ClosedRange<Double>
    
    var body: some View {
        VStack(spacing: 12) {
            // Category title with info icon
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    // Info button action
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
            }
            
            // Description
            Text("for sports, fitness, and stretching")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Range slider
            VStack(spacing: 8) {
                RangeSlider(
                    range: $range,
                    bounds: -7...7,
                    step: 1
                )
                
                // Scale labels
                HStack {
                    ForEach([-7, -5, -3, 3, 5, 7], id: \.self) { value in
                        Text("\(Int(value))")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        
                        if value != 7 {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(height: 4)
                    .cornerRadius(2)
                
                // Active range
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 4)
                    .cornerRadius(2)
                    .offset(x: range.lowerBound * geometry.size.width / (bounds.upperBound - bounds.lowerBound))
                    .frame(width: (range.upperBound - range.lowerBound) * geometry.size.width / (bounds.upperBound - bounds.lowerBound))
                
                // Lower thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .offset(x: range.lowerBound * geometry.size.width / (bounds.upperBound - bounds.lowerBound) - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + (value.location.x / geometry.size.width) * (bounds.upperBound - bounds.lowerBound)
                                let clampedValue = max(bounds.lowerBound, min(newValue, range.upperBound - step))
                                range = clampedValue...range.upperBound
                            }
                    )
                
                // Upper thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .offset(x: range.upperBound * geometry.size.width / (bounds.upperBound - bounds.lowerBound) - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + (value.location.x / geometry.size.width) * (bounds.upperBound - bounds.lowerBound)
                                let clampedValue = min(bounds.upperBound, max(newValue, range.lowerBound + step))
                                range = range.lowerBound...clampedValue
                            }
                    )
            }
        }
        .frame(height: 20)
    }
}

#Preview {
    CategoriesSelectionView(viewModel: OnboardingViewModel())
}
