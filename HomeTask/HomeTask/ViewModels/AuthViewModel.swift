//
//  AuthViewModel.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI
import Alamofire
import LocalAuthentication
import KeychainAccess

enum LoginResult {
    case success
    case error
}

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String? = nil
    
    private let keychain = Keychain(service: "com.yourapp.githubclient")
    
    // TODO: use a fake url, not really to login github
    func login(username: String, password: String) async {
        let parameters = ["username": username, "password": password]
        
        let _ = await AF.request(AppConstants.MockData.url, method: .post, parameters: parameters).responseJSON { res in
            switch res.result {
            case.success( _):
                if username == AppConstants.MockData.validUserName && password == AppConstants.MockData.validPassword {
                    // Save the user data securely
                    self.updateUserData(username: username, password: password)
                    self.isLoggedIn = true
                } else {
                    self.errorMessage = "Login Error"
                }
            case.failure( _):
                self.errorMessage = "Service Error"
            }
        }
    }
    
    private func updateUserData(username: String, password: String) {
        self.keychain["username"] = username
        self.keychain["password"] = password
    }
    
    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to login to your account"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        if let username = self.keychain["username"], let password = self.keychain["password"] {
                            Task {
                                await self.login(username: username, password: password)
                            }
                        }
                    } else {
                        self.errorMessage = "Biometric authentication failed: \(String(describing: authenticationError?.localizedDescription))"
                    }
                }
            }
        } else {
            self.errorMessage = "Biometric authentication not available"
        }
    }
    
    @MainActor
    func logout() async {
        isLoggedIn = false
        errorMessage = ""
        keychain["username"] = nil
        keychain["password"] = nil
    }
}
