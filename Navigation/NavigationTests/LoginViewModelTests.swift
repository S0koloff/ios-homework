//
//  LoginViewModelTests.swift
//  NavigationTests
//
//  Created by Sokolov on 24.02.2023.
//

import XCTest
@testable import Navigation

class LoginVC_mock: LogInViewController {
    
    
    func validEmail(email: String) -> Bool {
        email.isValidEmail ? true : false
    }
    
    func checker(login: String, pass: String) {
        
        CheckerService().checkCredentials(for: login, and: pass) { result in
            switch result {
            case .success(let userr):
                _ = userr
            case .failure: break
                    
            }
        }
    }
}

final class LoginViewModelTests: XCTestCase {
    
    var loginVC = LoginVC_mock()
    
    func testEmailValidator1() throws {
        XCTAssertFalse(loginVC.validEmail(email: "avavava"))
    }
    
    func testEmailValidator2() throws {
        XCTAssertEqual(loginVC.validEmail(email: "ava@ava.ava"), true)
    }
    
    func testChecker1() throws {
        XCTAssertNotNil(loginVC.checker(login: "fff", pass: "fff"))
    }

}
