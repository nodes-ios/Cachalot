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
}

extension Cacher {
    func save(data: Data, at path: URL) throws {
        try data.write(to: path, options: [.atomicWrite])
    }
    
    func value(at path: URL) throws -> Data {
        return try Data(contentsOf: path)
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
