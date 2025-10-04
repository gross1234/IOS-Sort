//
//  ProfileSetupView.swift
//  IOS Sort
//
//  Created by Gabe Ross on 10/4/25.
//

import SwiftUI

struct ProfileSetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showingImagePicker = false
    @State private var showingDatePicker = false
    
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
            
            // Pink Header Section
            VStack(spacing: 8) {
                Text("Set up your profile")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Upload your profile picture below")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.7))
            }
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity)
            .background(Color.pink.opacity(0.1))
            
            // Profile Picture Upload
            VStack(spacing: 20) {
                Button(action: {
                    showingImagePicker = true
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 120, height: 120)
                        
                        if let profileImage = viewModel.selectedProfileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "photo")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .background(
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 20, height: 20)
                                    )
                                    .offset(x: 20, y: -20)
                            }
                        }
                    }
                }
                
                // Input Fields
                VStack(spacing: 16) {
                    // Username
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        TextField("Enter username", text: $viewModel.profile.username)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Gender
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        Menu {
                            ForEach(UserProfile.Gender.allCases, id: \.self) { gender in
                                Button(gender.rawValue) {
                                    viewModel.profile.gender = gender
                                }
                            }
                        } label: {
                            HStack {
                                Text(viewModel.profile.gender.rawValue)
                                    .foregroundColor(viewModel.profile.gender == .notSpecified ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12))
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Date of Birth
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        Button(action: {
                            showingDatePicker = true
                        }) {
                            HStack {
                                Text(viewModel.profile.dateOfBirth?.formatted(date: .abbreviated, time: .omitted) ?? "Date of birth (optional)")
                                    .foregroundColor(viewModel.profile.dateOfBirth == nil ? .gray : .black)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Phone
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        TextField("Phone (optional)", text: $viewModel.profile.phone)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.phonePad)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Continue Button
                    Button(action: {
                        viewModel.updateProfile()
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
                    .disabled(!viewModel.canProceedFromProfile())
                    
                    // Select Property
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        TextField("Select property", text: $viewModel.profile.property)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Religious Association
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.gray)
                            .frame(width: 20)
                        
                        TextField("Do you have a religious association?", text: $viewModel.profile.religiousAssociation)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Spacer()
        }
        .background(Color.white)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedProfileImage)
        }
        .sheet(isPresented: $showingDatePicker) {
            DatePicker(
                "Date of Birth",
                selection: Binding(
                    get: { viewModel.profile.dateOfBirth ?? Date() },
                    set: { viewModel.profile.dateOfBirth = $0 }
                ),
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(WheelDatePickerStyle())
            .presentationDetents([.medium])
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

#Preview {
    ProfileSetupView(viewModel: OnboardingViewModel())
}
