//
//  ContentView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SortViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack {
                    Text("Sorting Algorithms")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Visualize different sorting algorithms")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Algorithm Selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Algorithm")
                        .font(.headline)
                    
                    Picker("Sort Algorithm", selection: $viewModel.sortAlgorithm) {
                        ForEach(SortViewModel.SortAlgorithm.allCases, id: \.self) { algorithm in
                            Text(algorithm.rawValue).tag(algorithm)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                
                // Controls
                HStack(spacing: 16) {
                    Button("Generate Numbers") {
                        viewModel.generateRandomNumbers()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isSorting)
                    
                    Button(viewModel.isSorting ? "Sorting..." : "Sort") {
                        Task {
                            await viewModel.sortNumbers()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isSorting || viewModel.numbers.isEmpty)
                }
                .padding(.horizontal)
                
                // Visualization
                if !viewModel.numbers.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Array Visualization")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .bottom, spacing: 4) {
                                ForEach(Array(viewModel.numbers.enumerated()), id: \.offset) { index, number in
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.7))
                                        .frame(width: 20, height: CGFloat(number) * 3)
                                        .overlay(
                                            Text("\(number)")
                                                .font(.caption2)
                                                .foregroundColor(.white)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("IOS Sort")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
