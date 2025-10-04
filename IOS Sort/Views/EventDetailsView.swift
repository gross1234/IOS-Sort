//
//  EventDetailsView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct EventDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header with close button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // Event image
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.3))
                        .frame(height: 250)
                        .overlay(
                            VStack {
                                Image(systemName: "leaf")
                                    .font(.system(size: 50))
                                    .foregroundColor(.green)
                                Text("Environmental Activity")
                                    .font(.system(size: 16))
                                    .foregroundColor(.green)
                            }
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    
                    // Event title and description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("The Tampa Bay Estuary Program")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("This partnership-driven organization is dedicated to restoring and protecting the hear...read more")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Price and join button
                    HStack {
                        VStack(alignment: .leading) {
                            Text("$50")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Almost full")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Navigate to payment
                        }) {
                            Text("Join event")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Event details
                    VStack(alignment: .leading, spacing: 16) {
                        EventDetailRow(icon: "person", text: "National Estuary program")
                        EventDetailRow(icon: "location", text: "105 Street, Elver Ground")
                        EventDetailRow(icon: "calendar", text: "07/23/2022 · 08:00 am - 5:00 pm")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Interaction buttons
                    HStack(spacing: 20) {
                        Button(action: {}) {
                            Image(systemName: "message")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "questionmark.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "paperplane")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack(spacing: 4) {
                                Image(systemName: "person")
                                    .font(.system(size: 16))
                                Image(systemName: "plus")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // Agenda section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Agenda")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        VStack(spacing: 12) {
                            AgendaItem(time: "9:30 AM", activity: "Stretch", progress: 0.9)
                            AgendaItem(time: "9:45 AM", activity: "Roll Out", progress: 0.1)
                            AgendaItem(time: "9:30 AM", activity: "Intense", progress: 0.1)
                        }
                        
                        Button("See more agenda items") {
                            // Show more agenda
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    // Attendees section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            // Profile pictures
                            HStack(spacing: -8) {
                                Circle()
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("A")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.blue)
                                    )
                                
                                Circle()
                                    .fill(Color.green.opacity(0.3))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("B")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.green)
                                    )
                                
                                Circle()
                                    .fill(Color.orange.opacity(0.3))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Text("MW")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.orange)
                                    )
                            }
                            
                            Text("30 friends, family, and followers will attend")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        
                        // Demographics chart
                        HStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                                    .frame(width: 80, height: 80)
                                
                                Circle()
                                    .trim(from: 0, to: 0.6)
                                    .stroke(Color.blue, lineWidth: 8)
                                    .frame(width: 80, height: 80)
                                    .rotationEffect(.degrees(-90))
                                
                                Text("253")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 8, height: 8)
                                    Text("Male, Camping")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                    Text("152")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                
                                HStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.5))
                                        .frame(width: 8, height: 8)
                                    Text("Female, Camping")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                    Text("101")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        // Filter buttons
                        HStack {
                            Text("Filter by")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Button("Gender") {
                                // Filter by gender
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                            
                            Button("Interests") {
                                // Filter by interests
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                            
                            Button("Location") {
                                // Filter by location
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(4)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    
                    // Location details
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("About this location")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button("See less") {
                                // Collapse location details
                            }
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                        }
                        
                        // Map placeholder
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 150)
                            .overlay(
                                VStack {
                                    Image(systemName: "map")
                                        .font(.system(size: 30))
                                        .foregroundColor(.gray)
                                    Text("Melbourne")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            LocationDetailRow(icon: "location", text: "105 Street, Elver Ground")
                            LocationDetailRow(icon: "figure.roll", text: "Handicap Accessible")
                            LocationDetailRow(icon: "car", text: "Free Parking")
                            LocationDetailRow(icon: "building", text: "Historical Building, 1924")
                            LocationDetailRow(icon: "mic", text: "Karaoke")
                            LocationDetailRow(icon: "link", text: "rossandprocter.com")
                        }
                        
                        // Final join button
                        Button(action: {
                            // Navigate to payment
                        }) {
                            Text("Join event")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                }
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}

struct EventDetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

struct AgendaItem: View {
    let time: String
    let activity: String
    let progress: Double
    
    var body: some View {
        HStack {
            Text(time)
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: 60, alignment: .leading)
            
            Text(activity)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Spacer()
            
            // Progress bar
            HStack(spacing: 2) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 20 * progress, height: 4)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 20 * (1 - progress), height: 4)
            }
            .frame(width: 20)
        }
    }
}

struct LocationDetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 16)
            
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}

#Preview {
    EventDetailsView()
}
