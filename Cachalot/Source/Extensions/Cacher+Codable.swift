//
//  Cacher+Codable.swift
//  Cachalot
//
//  Created by Chris Combs on 05/06/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation

extension Cacher {
    public func save<T: Codable>(_ value: T, forKey key: String) throws {
        let destination = path(forKey: key)
        let data = try encoder.encode(value)
        try save(data: data, at: destination)
    }
    
    public func value<T: Codable>(forKey key: String) throws -> T? {
        let destination = path(forKey: key)
        do {
            let data = try value(at: destination)
            return try decoder.decode(T.self, from: data)
        } catch CocoaError.fileReadNoSuchFile {
            return nil
        }
    }
}

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()
