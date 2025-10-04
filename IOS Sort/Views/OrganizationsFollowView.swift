//
//  OrganizationsFollowView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct OrganizationsFollowView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var followedOrganizations: Set<String> = []
    
    private let contactsOrganizations = [
        Organization(
            id: "flex-yoga-1",
            name: "Flex Yoga",
            address: "105 Street, Elver ground",
            rating: 4.5,
            imageName: "yoga-class",
            isFromContacts: true
        )
    ]
    
    private let suggestedOrganizations = [
        Organization(
            id: "flex-yoga-2",
            name: "Flex Yoga",
            address: "105 Street, Elver ground",
            rating: 4.5,
            imageName: "yoga-class",
            isFromContacts: false
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
            
            // Filter Icon
            VStack(spacing: 20) {
                // Custom Filter Icon
                ZStack {
                    // Blue top part
                    Image(systemName: "triangle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue.opacity(0.7))
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
            
            // Title and subtitle
            VStack(spacing: 16) {
                Text("We found some organizations in your area you may like")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Text("Follow organization to get access to new events, friends registrations, and reviews & photos")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 30)
            
            // Organizations list
            ScrollView {
                VStack(spacing: 24) {
                    // Contacts organizations section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Contacts organizations")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        ForEach(contactsOrganizations, id: \.id) { organization in
                            OrganizationCard(
                                organization: organization,
                                isFollowed: followedOrganizations.contains(organization.id),
                                onFollowToggle: {
                                    toggleFollow(for: organization.id)
                                }
                            )
                        }
                    }
                    
                    // Separator line
                    HStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 2)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 2)
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 2)
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 2)
                    }
                    .frame(height: 2)
                    
                    // Suggested organizations section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Suggested organizations")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        ForEach(suggestedOrganizations, id: \.id) { organization in
                            OrganizationCard(
                                organization: organization,
                                isFollowed: followedOrganizations.contains(organization.id),
                                onFollowToggle: {
                                    toggleFollow(for: organization.id)
                                }
                            )
                        }
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
    
    private func toggleFollow(for organizationId: String) {
        if followedOrganizations.contains(organizationId) {
            followedOrganizations.remove(organizationId)
        } else {
            followedOrganizations.insert(organizationId)
        }
    }
}

struct Organization {
    let id: String
    let name: String
    let address: String
    let rating: Double
    let imageName: String
    let isFromContacts: Bool
}

struct OrganizationCard: View {
    let organization: Organization
    let isFollowed: Bool
    let onFollowToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Organization image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "building.2")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                )
            
            // Organization details
            VStack(alignment: .leading, spacing: 4) {
                Text(organization.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text(organization.address)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.yellow)
                    
                    Text("\(organization.rating, specifier: "%.1f")")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            // Follow button
            Button(action: onFollowToggle) {
                Text(isFollowed ? "Following" : "Follow")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(isFollowed ? Color.green : Color.gray)
                    .cornerRadius(16)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    OrganizationsFollowView(viewModel: OnboardingViewModel())
}
