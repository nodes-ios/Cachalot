//
//  Cacher+UIImage.swift
//  Cacher
//
//  Created by Chris Combs on 05/06/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

public enum ImageQuality {
    case png
    case jpg(Double)
}

extension Cacher {
    public func save(_ value: UIImage, forKey key: String, quality: ImageQuality = .png) throws {
        let destination = path(forKey: key)
        let data: Data?
        switch quality {
        case .png:
            data = value.pngData()
        case .jpg(let compression):
            data = value.jpegData(compressionQuality: CGFloat(compression))
        }
        if let data = data {
            try save(data: data, at: destination)
        }
      
    }
    
    public func value(forKey key: String) throws -> UIImage? {
        let destination = path(forKey: key)
        do {
            let data = try value(at: destination)
            return UIImage(data: data)
        } catch CocoaError.fileReadNoSuchFile {
            return nil
        }        
    }
}
