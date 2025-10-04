//
//  MainAppView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct MainAppView: View {
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    // Left icons
                    HStack(spacing: 16) {
                        Image(systemName: "globe")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        
                        Image(systemName: "person.circle")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // Sort logo
                    HStack(spacing: 4) {
                        ZStack {
                            Image(systemName: "triangle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.blue)
                                .rotationEffect(.degrees(180))
                                .offset(y: -2)
                            
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 12, height: 16)
                                .cornerRadius(2)
                                .offset(y: 2)
                        }
                        
                        Text("Sort")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    // Right icons
                    HStack(spacing: 16) {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        
                        Image(systemName: "map")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Search bar
                HStack {
                    TextField("Search events", text: $searchText)
                        .font(.system(size: 16))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.trailing, 16)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                
                // Clear search button
                if !searchText.isEmpty {
                    HStack {
                        Button("Clear search") {
                            searchText = ""
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                }
                
                // Main content
                ScrollView {
                    VStack(spacing: 24) {
                        // Featured event
                        FeaturedEventCard()
                        
                        // Your organizations section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(height: 2)
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 2)
                            }
                            .frame(height: 2)
                            
                            Text("Your organizations")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    OrganizationCard(
                                        title: "Bolder adventure park",
                                        address: "2324 W Warrior Trl, Grand Prairie, TX 75052",
                                        imageName: "campfire"
                                    )
                                    
                                    OrganizationCard(
                                        title: "Escape The Room",
                                        address: "11661 Preston Rd #184, Dallas, TX",
                                        imageName: "escape-room"
                                    )
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        // New events section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Rectangle()
                                    .fill(Color.red)
                                    .frame(height: 2)
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(height: 2)
                            }
                            .frame(height: 2)
                            
                            Text("New events")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            EventCard(
                                title: "Sams Scuba School",
                                date: "July 5, 2022 · 7:00 - 11:00pm",
                                location: "Xtream Club · 105 Street, Elver ground",
                                imageName: "scuba-diving"
                            )
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
                
                // Bottom navigation
                HStack(spacing: 0) {
                    TabButton(icon: "house", title: "My orgs", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    TabButton(icon: "calendar", title: "Calendar", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    
                    TabButton(icon: "message", title: "Chats", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    
                    TabButton(icon: "location", title: "Explore", isSelected: selectedTab == 3) {
                        selectedTab = 3
                    }
                    
                    TabButton(icon: "person", title: "Profile", isSelected: selectedTab == 4) {
                        selectedTab = 4
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .background(Color.white)
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}

struct FeaturedEventCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Event image
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.green.opacity(0.3))
                .frame(height: 200)
                .overlay(
                    VStack {
                        Image(systemName: "leaf")
                            .font(.system(size: 40))
                            .foregroundColor(.green)
                        Text("Environmental Activity")
                            .font(.system(size: 14))
                            .foregroundColor(.green)
                    }
                )
            
            // Event details
            VStack(alignment: .leading, spacing: 8) {
                Text("July 5, 2022 · 800 - 5:00pm")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text("The Tampa Bay Estuary Program")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "location")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text("National Estuary program · 15232 E Hampden")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct OrganizationCard: View {
    let title: String
    let address: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 150, height: 100)
                .overlay(
                    Image(systemName: imageName == "campfire" ? "flame" : "door.left.hand.open")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                )
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
                .lineLimit(2)
            
            HStack {
                Image(systemName: "location")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text(address)
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .frame(width: 150)
    }
}

struct EventCard: View {
    let title: String
    let date: String
    let location: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.3))
                .frame(height: 120)
                .overlay(
                    Image(systemName: "figure.pool.swim")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(date)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "location")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                    
                    Text(location)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct TabButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 40, height: 40)
                    }
                    
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(isSelected ? .blue : .gray)
                }
                
                Text(title)
                    .font(.system(size: 10))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainAppView()
}
