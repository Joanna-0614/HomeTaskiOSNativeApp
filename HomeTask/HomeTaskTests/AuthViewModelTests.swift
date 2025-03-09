//
//  AuthViewModelTests.swift
//  HomeTaskTests
//
//  Created by 林彩霞 on 2025/3/9.
//

import XCTest
@testable import HomeTask
import Alamofire

final class AuthViewModelTests: XCTestCase {

    var authViewModel: AuthViewModel!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        authViewModel = AuthViewModel()
        mockURLSession = MockURLSession()
    }

    override func tearDownWithError() throws {
        authViewModel = nil
        mockURLSession = nil
    }

    func testLoginSuccess() async throws {
        // 加载模拟的成功响应 JSON 文件
        let mockData = try loadMockData(from: "mock_login_success")

        // 这里模拟 Alamofire 的成功响应
        let mockResponse = AFDataResponse<Any>(
            request: nil,
            response: HTTPURLResponse(url: URL(string: AppConstants.MockData.url)!, statusCode: 200, httpVersion: nil, headerFields: nil),
            data: mockData,
            metrics: nil,
            serializationDuration: 0,
            result: .success(mockData as Any)
        )

        // 使用 XCTUnwrap 确保响应存在
        _ = try! XCTUnwrap(mockResponse)

        await authViewModel.login(username: AppConstants.MockData.validUserName, password: AppConstants.MockData.validPassword)
        XCTAssertNil(authViewModel.errorMessage, "There should be no error message on successful login")
    }

    func testLoginFailure() async throws {
        await authViewModel.login(username: "invalidUser", password: "invalidPassword")
        XCTAssertFalse(authViewModel.isLoggedIn, "Login should fail with invalid credentials")
    }

    func testLogout() async throws {
        await authViewModel.login(username: AppConstants.MockData.validUserName, password: AppConstants.MockData.validPassword)
        await authViewModel.logout()
        XCTAssertFalse(authViewModel.isLoggedIn, "User should be logged out after logout action")
    }

    private func loadMockData(from fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "MockDataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock data file not found"])
        }
        return try Data(contentsOf: url)
    }
}

// A easy Mock URLSession
class MockURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let mockData = Data()
        let mockResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        completionHandler(mockData, mockResponse, nil)
        return URLSession.shared.dataTask(with: request)
    }
}
