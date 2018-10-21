// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import Foundation

extension Dog {
    public static func autoRandom(firstName: String = String.random(), lastName: String? = String?.random(), age: Int = Int.random(), birthday: Date = Date.random(), photo: URL = URL.random(), favoriteToy: Toy = Toy.random(), toys: [Toy] = [Toy].random(), parents: [String : String] = [:]) -> Dog {
        return Dog.new(firstName: firstName, lastName: lastName, age: age, birthday: birthday, photo: photo, favoriteToy: favoriteToy, toys: toys, parents: parents)
    }
}
extension Toy {
    public static func autoRandom(name: String = String.random(), type: ToyType = ToyType.allCases.randomElement()!, isNew: Bool = Bool.random()) -> Toy {
        return Toy.new(name: name, type: type, isNew: isNew)
    }
}

extension Dog: Random {
    public static func random() -> Dog {
        return autoRandom()
    }
}
extension Toy: Random {
    public static func random() -> Toy {
        return autoRandom()
    }
}
