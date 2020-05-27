//
//  CachalotTests.swift
//  CachalotTests
//
//  Created by Chris Combs on 26/05/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import XCTest
@testable import Cachalot

class CachalotTests: XCTestCase {

    var cache: Cacher!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cache = Cacher()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cache = nil
    }

    func test_storeCachable() {
        let user = User.mock
        cache.save(user, forKey: "User")
    }
    
    func test_loadCachable() {
        var user: User? = User.mock
        cache.save(user!, forKey: "User")
        user = nil
        user = cache.value(forKey: "User")
        
        XCTAssertNotNil(user, "Failed to load value from cache")
    }
    
    func test_loadNilFromCache() {
        let value: User? = cache.value(forKey: "Something nil")
        XCTAssertNil(value, "Loaded invalid data from cache")
    }

}
