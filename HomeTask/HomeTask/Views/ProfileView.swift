//
//  ProfileView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            if let avatar = profileViewModel.avatar {
                Image(uiImage: avatar)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            } else {
                Image("wind")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .clipShape(Circle())
            }

            Button(action: {
                showingImagePicker = true
            }) {
                Text("Change Avatar")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    Task {
                        await profileViewModel.changeAvatar(image: image)
                    }
                }
            }
        }
    }
}
