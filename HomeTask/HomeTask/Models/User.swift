//
//  User.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/7.
//

import Foundation
import SwiftUI

struct User: Codable, Equatable, Identifiable {
    var id: Int64
    var photo: String
    var thumbnail: String
    var firstName: String
    var lastName: String
    var email: String
    var experience: Int64
    var rate: Int64
    var bio: String
    var details: String
    var skills: [String]
    var tags: [String]
}

struct Skill: Codable, Equatable, Hashable {
    var id: String
}
