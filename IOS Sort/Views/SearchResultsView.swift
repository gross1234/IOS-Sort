//
//  SearchResultsView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct SearchResultsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
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
                
                // Search results section
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
                    
                    Text("Search results")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                    
                    // Search result cards
                    ScrollView {
                        VStack(spacing: 16) {
                            SearchResultCard(
                                title: "Sams Scuba School",
                                date: "July 5, 2022 · 7:00 - 11:00pm",
                                location: "Xtream Club · 105 Street, Elver ground",
                                imageName: "scuba-diving"
                            )
                            
                            SearchResultCard(
                                title: "The Tampa Bay Estuary Program",
                                date: "July 5, 2022 · 8:00 - 5:00pm",
                                location: "National Estuary program · 15232 E Hampden",
                                imageName: "environmental"
                            )
                            
                            SearchResultCard(
                                title: "Bolder Adventure Park",
                                date: "July 6, 2022 · 9:00 - 6:00pm",
                                location: "2324 W Warrior Trl, Grand Prairie, TX",
                                imageName: "adventure"
                            )
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
                
                Spacer()
                
                // Bottom navigation
                HStack(spacing: 0) {
                    TabButton(icon: "house", title: "My orgs", isSelected: false) {}
                    TabButton(icon: "calendar", title: "Calendar", isSelected: false) {}
                    TabButton(icon: "message", title: "Chats", isSelected: false) {}
                    TabButton(icon: "location", title: "Explore", isSelected: true) {}
                    TabButton(icon: "person", title: "Profile", isSelected: false) {}
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

struct SearchResultCard: View {
    let title: String
    let date: String
    let location: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Event image
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.3))
                .frame(height: 150)
                .overlay(
                    VStack {
                        Image(systemName: imageName == "scuba-diving" ? "figure.pool.swim" : 
                              imageName == "environmental" ? "leaf" : "mountain.2")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                        Text(imageName == "scuba-diving" ? "Scuba Diving" : 
                             imageName == "environmental" ? "Environmental" : "Adventure")
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                    }
                )
            
            // Event details
            VStack(alignment: .leading, spacing: 8) {
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
        .onTapGesture {
            // Navigate to event details
        }
    }
}

#Preview {
    SearchResultsView()
}
