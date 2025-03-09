//
//  Constants.swift
//  HomeTask
//
//  Created by 林彩霞 on 2025/3/9.
//

struct AppConstants {
    // mock data for login
    struct MockData {
        static let validUserName = "Test"
        static let validPassword = "Password"
        static let url = "https://hws.dev/designers.json"
    }
    
    struct Network {
        static let newsURL = "https://github.blog/feed/"
        static let imageSuccessURL = "https://kkimgs.yisou.com/ims?kt=url&at=ori&key=aHR0cHM6Ly9zdGF0aWMwMDEuaW5mb3EuY24vcmVzb3VyY2UvaW1hZ2UvN2IvMzcvN2IzOTcyYzgxMDk5NTgyNjAyZWY5ZTNlMmM0ZjBmMzcuanBn&sign=yx:K15F_Q_CM8gMsaBeOkk1hAxhmJs=&tv=0_0"
        static let imageFailureURL = "https://via.placeholder.com/invalid-image"
    }
}
