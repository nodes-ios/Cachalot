//
//  Cachalot.swift
//  Cachalot
//
//  Created by Chris Combs on 26/05/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation

public typealias Cachable = DataRepresentable & DataInitializable

public protocol DataRepresentable {
    var dataRepresentation: Data { get }
}

public protocol DataInitializable {
    init(data: Data)
}

public class Cacher {
    private let fileManager = FileManager.default
    private var directory: URL!
    
    public init() throws {
        guard let directoryPath = directoryPath else {
            throw CachalotError.directoryCreation
        }
        directory = directoryPath
        
        guard fileManager.fileExists(atPath: directory.absoluteString) else {
            return
        }
        
        try fileManager.createDirectory(at: directory, withIntermediateDirectories: true,
                                        attributes: nil)
    }
    
    public func save<T: Cachable>(_ value: T, forKey key: String) throws {
        let destination = path(forKey: key)
        try value.dataRepresentation.write(to: destination, options: [.atomicWrite])
    }
    
    public func value<T: Cachable>(forKey key: String) -> T? {
        let destination = path(forKey: key)
        if let data = try? Data(contentsOf: destination) {
            return T(data: data)
        } else {
            return nil
        }
    }
}


extension Cacher {
    var directoryPath: URL? {
        guard
            let base: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first,
            let url = URL(string: base)?.appendingPathComponent("Cachalot", isDirectory: true)
        else {
            return nil
        }
        return url
    }
    
    func path(forKey key: String) -> URL {
        return directory.appendingPathComponent(key, isDirectory: false)
    }
}



