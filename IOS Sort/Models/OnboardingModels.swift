//
//  OnboardingModels.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import Foundation

// MARK: - Onboarding Flow Models

struct OnboardingData {
    var interests: [EventInterest] = []
    var profile: UserProfile?
    var phoneNumber: String = ""
    var otpCode: String = ""
    var isLoggedIn: Bool = false
}

struct EventInterest: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let icon: String
    var isSelected: Bool = false
    
    static let allInterests = [
        EventInterest(name: "Music", icon: "music.note"),
        EventInterest(name: "Sports", icon: "sportscourt"),
        EventInterest(name: "Food", icon: "fork.knife"),
        EventInterest(name: "Art", icon: "paintbrush"),
        EventInterest(name: "Technology", icon: "laptopcomputer"),
        EventInterest(name: "Travel", icon: "airplane"),
        EventInterest(name: "Fitness", icon: "figure.run"),
        EventInterest(name: "Education", icon: "book"),
        EventInterest(name: "Gaming", icon: "gamecontroller"),
        EventInterest(name: "Photography", icon: "camera"),
        EventInterest(name: "Fashion", icon: "tshirt"),
        EventInterest(name: "Movies", icon: "tv"),
        EventInterest(name: "Dancing", icon: "figure.dance"),
        EventInterest(name: "Cooking", icon: "oven"),
        EventInterest(name: "Reading", icon: "book.closed"),
        EventInterest(name: "Nature", icon: "leaf")
    ]
}

struct UserProfile {
    var username: String = ""
    var gender: Gender = .notSpecified
    var dateOfBirth: Date?
    var phone: String = ""
    var property: String = ""
    var religiousAssociation: String = ""
    var profileImage: String? = nil
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        case other = "Other"
        case notSpecified = "Prefer not to say"
    }
}

// MARK: - Onboarding Steps

enum OnboardingStep: Int, CaseIterable {
    case phoneNumber = 0
    case otpVerification = 1
    case profile = 2
    case decision = 3
    case categories = 4
    case days = 5
    case times = 6
    case interests = 7
    case organizations = 8
    case completed = 9

    var title: String {
        switch self {
        case .phoneNumber:
            return "User Login / Sign up"
        case .otpVerification:
            return "OTP Verification"
        case .profile:
            return "Set up your profile"
        case .decision:
            return "Continue Setup?"
        case .categories:
            return "Choose Categories!"
        case .days:
            return "What days work best"
        case .times:
            return "What times work best"
        case .interests:
            return "Choose interests!"
        case .organizations:
            return "Follow Organizations"
        case .completed:
            return "Welcome to Sort!"
        }
    }

    var subtitle: String {
        switch self {
        case .phoneNumber:
            return "by continuing you agree to Sort's terms & conditions and privacy policy"
        case .otpVerification:
            return "Enter the OTP sent to your mobile number"
        case .profile:
            return "Upload your profile picture below"
        case .decision:
            return "Would you like to complete your profile setup?"
        case .categories:
            return "Personalize your feed to see more events love and less of what you don't."
        case .days:
            return "Personalize your feed to see more events you love and less of what you don't."
        case .times:
            return "Personalize your feed to see more events you love and less of what you don't."
        case .interests:
            return "Choose specific interests for future registrations"
        case .organizations:
            return "Follow organizations to get access to new events, friends registrations, and reviews & photos"
        case .completed:
            return "You're all set!"
        }
    }
}
