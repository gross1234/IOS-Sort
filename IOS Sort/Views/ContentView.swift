//
//  ContentView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Spacer()
                
                // Welcome content
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Welcome to Sort!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("You're all set up and ready to discover amazing events!")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Debug reset button (remove in production)
                Button("Reset Onboarding") {
                    UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
                    // Force app restart by exiting
                    exit(0)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.red)
                .padding(.bottom, 40)
            }
            .navigationTitle("Sort")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
