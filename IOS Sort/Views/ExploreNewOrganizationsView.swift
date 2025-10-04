//
//  ExploreNewOrganizationsView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ExploreNewOrganizationsView: View {
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
                    TextField("Search", text: $searchText)
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
                
                // Main content
                ScrollView {
                    VStack(spacing: 24) {
                        // Explore New organizations section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Explore New organizations")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Once you are following organizations they will pop up here for easy access to them, and to show all of their upcoming events!")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                            
                            // Blue placeholder area
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.1))
                                .frame(height: 200)
                                .overlay(
                                    VStack(spacing: 12) {
                                        Image(systemName: "building.2")
                                            .font(.system(size: 40))
                                            .foregroundColor(.blue.opacity(0.5))
                                        
                                        Text("No organizations followed yet")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.blue.opacity(0.7))
                                        
                                        Text("Follow organizations to see their events here")
                                            .font(.system(size: 12))
                                            .foregroundColor(.blue.opacity(0.5))
                                    }
                                )
                        }
                        .padding(.horizontal, 20)
                        
                        // Explore button
                        Button(action: {
                            // Navigate to organizations follow screen
                        }) {
                            Text("Explore!")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.gray.opacity(0.8))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        
                        // Illustration
                        VStack {
                            Image(systemName: "figure.water.fitness")
                                .font(.system(size: 60))
                                .foregroundColor(.blue.opacity(0.3))
                            
                            Text("Start exploring amazing events!")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 40)
                    }
                }
                
                Spacer()
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ExploreNewOrganizationsView()
}
