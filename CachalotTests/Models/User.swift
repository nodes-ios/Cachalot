//
//  User.swift
//  CachalotTests
//
//  Created by Chris Combs on 27/05/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation
import Cachalot

final class User: Codable {
    internal init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    let id: Int
    let name: String
    
    static var mock: User {
        return User(id: 0, name: "User")
    }
}



