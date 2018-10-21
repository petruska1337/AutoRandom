// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import Foundation


public extension Dog {
    public static func new(firstName: String, lastName: String?, age: Int, birthday: Date, photo: URL, favoriteToy: Toy, toys: [Toy], parents: [String : String]) -> Dog {
        return Dog(firstName: firstName, lastName: lastName, age: age, birthday: birthday, photo: photo, favoriteToy: favoriteToy, toys: toys, parents: parents)
    }
}


public extension Toy {
    public static func new(name: String, type: ToyType, isNew: Bool) -> Toy {
        return Toy(name: name, type: type, isNew: isNew)
    }
}


