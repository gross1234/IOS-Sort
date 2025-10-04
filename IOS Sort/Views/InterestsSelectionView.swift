//
//  InterestsSelectionView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct InterestsSelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedInterests: Set<String> = []
    
    private let interestCategories = [
        InterestCategory(
            name: "Activities",
            interests: ["Wellness", "Paint ball", "Painting", "Dance classes", "Cooking classes", "Mini Golf", "Run clubs", "Action sports", "Skating"]
        ),
        InterestCategory(
            name: "Trainers",
            interests: ["Cross fit", "Cycle Bar", "Swimming", "MMA", "Boxing", "Life coaching", "Run clubs", "MMA", "Tennis"]
        ),
        InterestCategory(
            name: "Community events",
            interests: ["Happy Hour", "Holiday celebration", "Book clubs", "Community Garden", "Game Nights", "Parades", "Farmers markets", "Open Mic"]
        ),
        InterestCategory(
            name: "Socializing",
            interests: ["Run clubs", "Night out", "Watch party", "Grill outs", "Book clubs", "Meetups", "Board games", "Celebration"]
        ),
        InterestCategory(
            name: "Thrill seeking",
            interests: ["Bungee jumping", "Shooting range", "White water rafting", "Off road atv", "Ziplining", "Go carting", "Skydiving"]
        ),
        InterestCategory(
            name: "Volunteering",
            interests: ["Shelter visit", "Senior care", "Cleanups", "Prison visits", "Charity 5K", "Child care", "Food packing", "Blood drive"]
        ),
        InterestCategory(
            name: "Churches",
            interests: ["Mass", "Confession", "Adoration", "Discussion groups", "Young adult group", "Retreats", "Prayer groups", "Better breakfast"]
        )
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
                Text("Choose interests!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Choose specific interests for future registrations")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
            
            // Interest categories
            ScrollView {
                VStack(spacing: 24) {
                    ForEach(interestCategories, id: \.name) { category in
                        InterestCategoryView(
                            category: category,
                            selectedInterests: $selectedInterests
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

struct InterestCategory {
    let name: String
    let interests: [String]
}

struct InterestCategoryView: View {
    let category: InterestCategory
    @Binding var selectedInterests: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Category name
            Text(category.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            // Interest tags
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100), spacing: 8)
            ], spacing: 8) {
                ForEach(category.interests, id: \.self) { interest in
                    InterestTag(
                        interest: interest,
                        isSelected: selectedInterests.contains(interest),
                        onTap: {
                            if selectedInterests.contains(interest) {
                                selectedInterests.remove(interest)
                            } else {
                                selectedInterests.insert(interest)
                            }
                        }
                    )
                }
            }
        }
    }
}

struct InterestTag: View {
    let interest: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(interest)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .white : .black)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.blue : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    InterestsSelectionView(viewModel: OnboardingViewModel())
}
