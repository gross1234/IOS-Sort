//
//  PaymentView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPaymentMethod = 0
    @State private var cardNumber = ""
    @State private var cardholderName = ""
    @State private var expireDate = ""
    @State private var cvv = ""
    @State private var saveInfo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Payment Method")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Invisible button for balance
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.clear)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Payment method selection
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Select Payment Method.")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Choose your preferred payment method.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            VStack(spacing: 12) {
                                PaymentMethodCard(
                                    title: "Credit/Debit",
                                    icon: "creditcard",
                                    isSelected: selectedPaymentMethod == 0
                                ) {
                                    selectedPaymentMethod = 0
                                }
                                
                                PaymentMethodCard(
                                    title: "Apple Pay",
                                    icon: "applelogo",
                                    isSelected: selectedPaymentMethod == 1
                                ) {
                                    selectedPaymentMethod = 1
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Order summary
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Order Summary")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            HStack {
                                Text("Tampa Bay Estuary Program")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("$450")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Taxes")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("$31.50")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Text("$481.50")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Card details (only show if Credit/Debit is selected)
                        if selectedPaymentMethod == 0 {
                            VStack(alignment: .leading, spacing: 16) {
                                // Card number
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Card Number")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    HStack {
                                        TextField("0000 0000 0000 0000", text: $cardNumber)
                                            .font(.system(size: 16))
                                            .keyboardType(.numberPad)
                                        
                                        Button(action: {
                                            // Scan card
                                        }) {
                                            Image(systemName: "camera")
                                                .font(.system(size: 16))
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                                .background(Color.red)
                                                .cornerRadius(15)
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                }
                                
                                // Cardholder name
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Cardholder Name")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                    
                                    TextField("ex. Ashley Smith", text: $cardholderName)
                                        .font(.system(size: 16))
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 12)
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(8)
                                }
                                
                                // Expire date and CVV
                                HStack(spacing: 16) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Expire Date")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.black)
                                        
                                        TextField("MM / YYYY", text: $expireDate)
                                            .font(.system(size: 16))
                                            .keyboardType(.numberPad)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(8)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("CVV/CVC")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.black)
                                        
                                        TextField("3-4 digits", text: $cvv)
                                            .font(.system(size: 16))
                                            .keyboardType(.numberPad)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 12)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                // Save information checkbox
                                HStack {
                                    Button(action: {
                                        saveInfo.toggle()
                                    }) {
                                        Image(systemName: saveInfo ? "checkmark.square.fill" : "square")
                                            .font(.system(size: 20))
                                            .foregroundColor(saveInfo ? .blue : .gray)
                                    }
                                    
                                    Text("Save your information")
                                        .font(.system(size: 14))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer(minLength: 100)
                    }
                }
                
                // Purchase button
                VStack {
                    Button(action: {
                        // Process payment
                    }) {
                        Text("Purchase")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
                .background(Color.white)
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
    }
}

struct PaymentMethodCard: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(isSelected ? Color.red.opacity(0.1) : Color.gray.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.red : Color.clear, lineWidth: 2)
            )
            .cornerRadius(8)
        }
    }
}

#Preview {
    PaymentView()
}
