//
//  SearchRepository.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/8.
//

struct SearchResults: Codable {
    let items: [Repository]
}

struct Repository: Codable, Identifiable {
    var id: Int
    let name: String
    let fullName: String
    let description: String?
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case description = "description"
        case htmlUrl = "html_url"
    }
}
