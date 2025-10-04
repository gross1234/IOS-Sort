//
//  ContentView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var hasFollowedOrganizations = false // This would come from UserDefaults or API
    
    var body: some View {
        Group {
            if hasFollowedOrganizations {
                MainAppView()
            } else {
                ExploreNewOrganizationsView()
            }
        }
        .onAppear {
            // Check if user has followed organizations
            // This would typically come from UserDefaults or API call
            checkUserOrganizations()
        }
    }
    
    private func checkUserOrganizations() {
        // Simulate checking if user has followed organizations
        // In a real app, this would check UserDefaults or make an API call
        hasFollowedOrganizations = UserDefaults.standard.bool(forKey: "hasFollowedOrganizations")
    }
}

#Preview {
    ContentView()
}
