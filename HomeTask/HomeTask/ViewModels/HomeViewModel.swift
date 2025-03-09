//
//  HomeViewModel.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @MainActor
    func logout(authViewModel: AuthViewModel) async {
        await authViewModel.logout()
    }
}
