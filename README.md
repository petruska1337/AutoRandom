### Problem
In testing many developers need to create some **input** data model which need for testing

```Swift
let dog = Dog.new(firstName: "some name", lastName: nil, age: 1, birthday: Date(), photo: URL(string: "google")!, favoriteToy: Toy.new(name: "", type: .training, isNew: false), toys: [], parents: [:])
dogsService.getDogsReturnValue = [dog]
sut.getDogsTrigger()
expect(sut.dogs.first?.firstName).to(equal(dog.firstName))
``` 
In this code i see two problems:
* You need to write the same boring code again and again, it is take some time, it is looks not so clean, it is contradicts principles of "lazy development"
* Usually when developers create models he wants to test behaviour with **any, random** data and show another developers that his method (under tests) ready for **any** data. But can we be sure that we tested with realy random data? More about this topic your can read [here(Monkey testing)](https://en.wikipedia.org/wiki/Monkey_testing) and [here (Fuzzing)](https://en.wikipedia.org/wiki/Fuzzing)

### Solution
To resolve this problem and make developer life easier i created [Sourcery](https://github.com/krzysztofzablocki/Sourcery) script which generate static method which return his random object. This method accept all model properties or use default **random** value. For generating random data i added extensions for swift types. This extensions also generate random count of objects in array and can return nil if property is optional.

<details>
<summary>Random.swift</summary>

```swift
public protocol Random {
    static func random() -> Self
}

extension Array: Random {
    private static func randomElement() -> Element? {
        guard Element.self is Random.Type else {
            return nil
        }
        return (Element.self as? Random.Type)?.random() as? Element
    }
    
    public static func random() -> [Element] {
        return (0...Int(arc4random() % 3))
            .map { _ in randomElement() }
            .compactMap{ $0 }
    }
}

extension Optional: Random {
    private static func randomElement() -> Wrapped? {
        guard Wrapped.self is Random.Type else {
            return nil
        }
        
        return (Wrapped.self as? Random.Type)?.random() as? Wrapped
    }
    
    public static func random() -> Wrapped? {
        return Int(arc4random() % 2) == 0
            ? nil
            : randomElement()
    }
}

extension String: Random {
    public static func random() -> String {
        return NSUUID().uuidString
    }
}

extension Int: Random {
    public static func random() -> Int {
        return Int(arc4random() % 200)
    }
}

extension Int32: Random {
    public static func random() -> Int32 {
        return Int32(arc4random() % 300)
    }
}

extension Int64: Random {
    public static func random() -> Int64 {
        return Int64(arc4random() % 300)
    }
}

extension Double: Random {
    public static func random() -> Double {
        return Double(arc4random() % 1000) / 100
    }
}

extension Float: Random {
    public static func random() -> Float {
        return Float(arc4random() % 1000) / 100
    }
}

extension Bool: Random {
    public static func random() -> Bool {
        return arc4random() % 2 == 1
    }
}

extension Data: Random {
    public static func random() -> Data {
        let bytes = [UInt32](repeating: 0, count: 10).map { _ in arc4random() }
        return Data(bytes: bytes, count: 10 )
    }
}

extension Date: Random {
    public static func random() -> Date {
        return Date(timeIntervalSince1970: Double.random())
    }
}

extension URL: Random {
    public static func random() -> URL {
        return [
            URL(string: "https://www.google.com/\(String.random())"),
            URL(string: "https://www.google.com/\(String.random())"),
            URL(string: "https://www.google.com/\(String.random())")
        ].compactMap{ $0 }.randomElement()!
    }
}

extension NSError {
    public static func random() -> NSError {
        return NSError(domain: .random(), code: .random(), userInfo: nil)
    }
}

```
</details>

### Installation
Installation is basically the same as in any other soursery scripts, in addition you need to add Random.swift file
If you are new to code generation i recommend you to start with reading about [it](https://www.raywenderlich.com/501-sourcery-tutorial-generating-swift-code-for-ios)

### Example
Input:
```Swift
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
    public let parents: [String : Dog]
}
``` 

Confirm to protocol

```Swift
public protocol AutoRandom: AutoInit {}

extension Dog: AutoRandom {}
extension Toy: AutoRandom {}
``` 

Outupt:

```Swift
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
``` 

And now you can simply create random dog:

```Swift
let dog1 = Dog.autoRandom()
let dog2 = Dog.autoRandom(firstName: "my special name")
``` 
You can try to experiment more after cloning example project, don't forget to `pod install`


### Known issue
The script dosen't support Dictionary type, it pass only empty dictionary as default parameter

### Find this interesting?

You can contact with me olehpetruch@gmail.com
