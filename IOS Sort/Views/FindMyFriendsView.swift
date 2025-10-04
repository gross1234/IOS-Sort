//
//  FindMyFriendsView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct FindMyFriendsView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var invitedContacts: Set<String> = []
    
    private let contacts = [
        Contact(
            id: "contact-1",
            name: "Name",
            mutualConnections: 2,
            avatarImage: "person.circle"
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
            
            // Title
            VStack(spacing: 16) {
                Text("Find my friends")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.vertical, 30)
            
            // Contacts section
            VStack(alignment: .leading, spacing: 16) {
                Text("Your contacts.")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(contacts, id: \.id) { contact in
                            ContactCard(
                                contact: contact,
                                isInvited: invitedContacts.contains(contact.id),
                                onInviteToggle: {
                                    toggleInvite(for: contact.id)
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100) // Space for continue button
                }
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
    
    private func toggleInvite(for contactId: String) {
        if invitedContacts.contains(contactId) {
            invitedContacts.remove(contactId)
        } else {
            invitedContacts.insert(contactId)
        }
    }
}

struct Contact {
    let id: String
    let name: String
    let mutualConnections: Int
    let avatarImage: String
}

struct ContactCard: View {
    let contact: Contact
    let isInvited: Bool
    let onInviteToggle: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: contact.avatarImage)
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                )
            
            // Contact details
            VStack(alignment: .leading, spacing: 4) {
                Text(contact.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Knows \(contact.mutualConnections) people on Sort.")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Invite button
            Button(action: onInviteToggle) {
                Text(isInvited ? "Invited" : "Invite")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(isInvited ? Color.green : Color.gray)
                    .cornerRadius(16)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    FindMyFriendsView(viewModel: OnboardingViewModel())
}
