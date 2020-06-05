//
//  CodableTests.swift
//  CachalotTests
//
//  Created by Chris Combs on 05/06/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import XCTest
@testable import Cachalot

class CodableTests: XCTestCase {
    var cache: Cacher!
     
     override func setUpWithError() throws {
         // Put setup code here. This method is called before the invocation of each test method in the class.
         cache = try! Cacher()
     }

     override func tearDownWithError() throws {
         // Put teardown code here. This method is called after the invocation of each test method in the class.
         cache = nil
     }
     func test_store_and_load_Codable() {
        var user: User? = User.mock
        XCTAssertNoThrow(try cache.save(user, forKey: "User"), "Error found when saving Codable model to disk")
        user = nil
        XCTAssertNoThrow(user = try cache.value(forKey: "User"), "Error found when loading Codable model from disk")
        XCTAssertNotNil(user, "Failed to load Codable value from cache")
     }
     
    func test_loadNilCodable() {
        var value: User?
        XCTAssertNoThrow(value = try cache.value(forKey: "Something nil"), "Error found when loading nil Codable model from disk")
        XCTAssertNil(value, "Loaded invalid data from cache")
    }
    
}
