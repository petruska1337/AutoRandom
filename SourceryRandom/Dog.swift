//
//  Dog.swift
//  SourceryRandom
//
//  Created by Петрічук Олег Аркадійовіч on 16.10.2018.
//  Copyright © 2018 Oleg Petrychuk. All rights reserved.
//

import Foundation

public enum ToyType: CaseIterable {
    case training
    case boll
    case bone
}

public struct Toy {
    public let name: String
    public let type: ToyType
    public let isNew: Bool
}

public struct Dog {
    public let firstName: String
    public let lastName: String?
    public let age: Int
    public let birthday: Date
    public let photo: URL
    public let favoriteToy: Toy
    public let toys: [Toy]
    public let parents: [String : String]
}
