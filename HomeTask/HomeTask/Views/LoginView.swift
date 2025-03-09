//
//  LoginView.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username: String = AppConstants.MockData.validUserName
    @State private var password: String = AppConstants.MockData.validPassword
    @Binding var showingLoginView: Bool

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5.0)
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                Task {
                    await authViewModel.login(username: username, password: password)
                    if authViewModel.isLoggedIn {
                        showingLoginView = false
                    }
                }
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5.0)
            }

            Button(action: {
                authViewModel.authenticateWithBiometrics()
                if authViewModel.isLoggedIn {
                    showingLoginView = false
                }
            }) {
                Text("Login with Biometrics")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(5.0)
            }
        }
        .padding()
    }
}
