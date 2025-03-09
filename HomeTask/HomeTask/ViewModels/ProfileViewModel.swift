//
//  ProfileViewModel.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var avatar: UIImage? = nil
    
    @MainActor
    func changeAvatar(image: UIImage) async {
        // Assuming the avatar image is stored locally
        avatar = image
    }
}
