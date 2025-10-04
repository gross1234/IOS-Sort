//
//  TimesPreferenceView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct TimesPreferenceView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var mondayRanges: [ClosedRange<Double>] = [9...17]
    @State private var tuesdayRanges: [ClosedRange<Double>] = [9...17]
    @State private var wednesdayRanges: [ClosedRange<Double>] = [9...17]
    @State private var thursdayRanges: [ClosedRange<Double>] = [9...17]
    @State private var fridayRanges: [ClosedRange<Double>] = [9...17]
    @State private var saturdayRanges: [ClosedRange<Double>] = [9...17]
    @State private var sundayRanges: [ClosedRange<Double>] = [9...17]
    
    private let timeLabels = ["7AM", "10AM", "12PM", "4PM", "7PM", "11PM"]
    private let timeValues: [Double] = [7, 10, 12, 16, 19, 23]
    
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
                Text("What times work best")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Personalize your feed to see more events you love and less of what you don't.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
            
            // Days with time sliders
            ScrollView {
                VStack(spacing: 24) {
                    DayTimeGroupView(day: "Monday", ranges: $mondayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Tuesday", ranges: $tuesdayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Wednesday", ranges: $wednesdayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Thursday", ranges: $thursdayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Friday", ranges: $fridayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Saturday", ranges: $saturdayRanges, timeLabels: timeLabels, timeValues: timeValues)
                    DayTimeGroupView(day: "Sunday", ranges: $sundayRanges, timeLabels: timeLabels, timeValues: timeValues)
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

struct DayTimeGroupView: View {
    let day: String
    @Binding var ranges: [ClosedRange<Double>]
    let timeLabels: [String]
    let timeValues: [Double]
    
    var body: some View {
        VStack(spacing: 12) {
            // Day name with minus button
            HStack {
                Text(day)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    if ranges.count > 1 {
                        ranges.removeLast()
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
                .disabled(ranges.count <= 1)
            }
            
            // Time range sliders
            ForEach(Array(ranges.enumerated()), id: \.offset) { index, range in
                VStack(spacing: 8) {
                    TimeRangeSlider(
                        range: $ranges[index],
                        bounds: 7...23,
                        step: 1,
                        timeLabels: timeLabels,
                        timeValues: timeValues
                    )
                    
                    // Time labels
                    HStack {
                        ForEach(Array(zip(timeLabels, timeValues)), id: \.1) { label, value in
                            Text(label)
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                            
                            if value != timeValues.last {
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            // Plus button to add more time ranges
            Button(action: {
                ranges.append(9...17)
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 16))
                    Text("Add more times")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundColor(.blue)
            }
        }
    }
}

struct TimeSliderView: View {
    let day: String
    @Binding var range: ClosedRange<Double>
    let timeLabels: [String]
    let timeValues: [Double]
    
    var body: some View {
        VStack(spacing: 12) {
            // Day name
            Text(day)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Time range slider
            VStack(spacing: 8) {
                TimeRangeSlider(
                    range: $range,
                    bounds: 7...23,
                    step: 1,
                    timeLabels: timeLabels,
                    timeValues: timeValues
                )
                
                // Time labels
                HStack {
                    ForEach(Array(zip(timeLabels, timeValues)), id: \.1) { label, value in
                        Text(label)
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        
                        if value != timeValues.last {
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct TimeRangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    let timeLabels: [String]
    let timeValues: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            let boundsWidth = bounds.upperBound - bounds.lowerBound
            let rangeWidth = range.upperBound - range.lowerBound
            let lowerOffset = (range.lowerBound - bounds.lowerBound) * geometry.size.width / boundsWidth
            let rangeWidthPixels = rangeWidth * geometry.size.width / boundsWidth
            
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
                    .offset(x: lowerOffset)
                    .frame(width: rangeWidthPixels)
                
                // Lower thumb
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .overlay(
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .offset(x: lowerOffset - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + (value.location.x / geometry.size.width) * boundsWidth
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
                    .offset(x: lowerOffset + rangeWidthPixels - 10)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newValue = bounds.lowerBound + (value.location.x / geometry.size.width) * boundsWidth
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
    TimesPreferenceView(viewModel: OnboardingViewModel())
}
