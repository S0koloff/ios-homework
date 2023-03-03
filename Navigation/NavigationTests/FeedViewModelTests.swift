//
//  FeedViewModelTests.swift
//  NavigationTests
//
//  Created by Sokolov on 24.02.2023.
//
import RealmSwift
import XCTest
@testable import Navigation

final class FeedViewModelTests: XCTestCase {
    
    let feedModel = FeedModel()

    func testFeedModel1() throws {
        XCTAssertNotNil(feedModel.checkWord(word: "10"))
    }
    
    func testFeedModel2() throws {
        XCTAssertTrue(feedModel.checkWord(word: "1"))
    }
    
    func testFeedModel3() throws {
        XCTAssertFalse(feedModel.checkWord(word: "2"))
    }

}
