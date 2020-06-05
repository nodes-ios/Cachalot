//
//  UIImageTests.swift
//  CachalotTests
//
//  Created by Chris Combs on 05/06/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import XCTest
@testable import Cachalot

class UIImageTests: XCTestCase {
    var cache: Cacher!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cache = try Cacher()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cache = nil
    }

    func test_store_and_load_UIImage() {
        var image: UIImage? = testImage
        XCTAssertNoThrow(try cache.save(image!, forKey: "Logo"), "Error found when saving UIImage to disk")
        image = nil
        XCTAssertNoThrow(image = try cache.value(forKey: "Logo"), "Error found when loading UIImage from disk")
        XCTAssertNotNil(image, "Failed to load UIImage value from cache")
    }
    
    func test_store_image_quality() {
        XCTAssertNoThrow(try cache.save(testImage, forKey: "Logo", quality: .png), "Error found when saving PNG UIImage to disk")
        XCTAssertNoThrow(try cache.save(testImage, forKey: "Logo", quality: .jpg(0.8)), "Error found when saving JPEG UIImage to disk")
    }
    
    func test_loadNilUIImage() {
        var value: UIImage?
        XCTAssertNoThrow(value = try cache.value(forKey: "Something nil"), "Error found when loading nil UIImage from disk")
        XCTAssertNil(value, "Loaded invalid data from cache")
    }
}
