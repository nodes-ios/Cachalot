//
//  Cachalot.swift
//  Cachalot
//
//  Created by Chris Combs on 26/05/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation


public class Cacher {
    private let fileManager = FileManager.default
    private var directory: URL!
    
    public init() throws {
        guard let directoryPath = directoryPath else {
            throw CachalotError.directoryCreation
        }
        directory = directoryPath
        
        guard !fileManager.fileExists(atPath: directory.absoluteString) else {
            return
        }
        
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true,
                                        attributes: nil)
    }
    
    public func save<T: Codable>(_ value: T, forKey key: String) throws {
        let destination = path(forKey: key)
        let data = try encoder.encode(value)
        try save(data: data, at: destination)
    }
    
    public func value<T: Codable>(forKey key: String) throws -> T? {
        let destination = path(forKey: key)
        if let data = value(at: destination) {
            return try decoder.decode(T.self, from: data)
        } else {
            return nil
        }
        
    }
    
}

extension Cacher {
    private func save(data: Data, at path: URL) throws {
        try data.write(to: path, options: [.atomicWrite])
    }
    
    private func value(at path: URL) -> Data? {
        if let data = try? Data(contentsOf: path) {
            return data
        } else {
            return nil
        }
    }
}

extension Cacher {
    var directoryPath: URL? {
        guard let base: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }
        return URL(fileURLWithPath: base).appendingPathComponent("Cachalot", isDirectory: true)        
    }
    
    func path(forKey key: String) -> URL {
        return directory.appendingPathComponent(key, isDirectory: false)
    }
}




private let decoder = JSONDecoder()
private let encoder = JSONEncoder()
