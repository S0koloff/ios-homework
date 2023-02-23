//
//  CheckerServiceTest.swift
//  NavigationTests
//
//  Created by Sokolov on 23.02.2023.
//

import Foundation
import XCTest
@testable import Navigation

class CheckerServiceTest: XCTestCase {
    
    func testCheckCredentials() {
        let checkerService = CheckerService()
        
        let login = "avava"
        let pass = "12121"
        
        checkerService.checkCredentials(for: login, and: pass)
        
        XCTAssertNil(xxx)
    }
}
