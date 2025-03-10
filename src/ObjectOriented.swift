// ObjectOriented.swift
// Examples of Swift's object-oriented programming features

// MARK: - Classes

// Basic class definition
class Animal {
    // Properties
    var name: String
    var age: Int
    
    // Initializer (constructor)
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // Method
    func makeSound() -> String {
        return "Some generic animal sound"
    }
    
    // Method with parameters
    func eat(food: String) -> String {
        return "\(name) is eating \(food)"
    }
}

// MARK: - Inheritance

// Subclass
class Dog: Animal {
    // Additional property
    var breed: String
    
    // Initializer that calls the superclass initializer
    init(name: String, age: Int, breed: String) {
        self.breed = breed
        super.init(name: name, age: age)
    }
    
    // Override method
    override func makeSound() -> String {
        return "Woof!"
    }
    
    // Additional method
    func fetch() -> String {
        return "\(name) is fetching the ball"
    }
}

// Another subclass
class Cat: Animal {
    // Additional property
    var isIndoor: Bool
    
    // Initializer
    init(name: String, age: Int, isIndoor: Bool) {
        self.isIndoor = isIndoor
        super.init(name: name, age: age)
    }
    
    // Override method
    override func makeSound() -> String {
        return "Meow!"
    }
    
    // Additional method
    func purr() -> String {
        return "\(name) is purring"
    }
}

// MARK: - Properties

class Temperature {
    // Stored property
    var celsius: Double
    
    // Computed property
    var fahrenheit: Double {
        get {
            return celsius * 9/5 + 32
        }
        set {
            celsius = (newValue - 32) * 5/9
        }
    }
    
    // Property observer
    var kelvin: Double = 0 {
        willSet {
            print("About to change kelvin from \(kelvin) to \(newValue)")
        }
        didSet {
            print("Changed kelvin from \(oldValue) to \(kelvin)")
            celsius = kelvin - 273.15
        }
    }
    
    // Lazy property - only initialized when first accessed
    lazy var description: String = {
        let calculation = "Complex calculation for temperature description"
        return "Temperature: \(celsius)°C, \(fahrenheit)°F, \(kelvin)K"
    }()
    
    init(celsius: Double) {
        self.celsius = celsius
        self.kelvin = celsius + 273.15
    }
}

// MARK: - Access Control

// Public class - accessible from any module
public class PublicClass {
    // Public property - accessible from any module
    public var publicProperty = "Public"
    
    // Internal property - accessible only within the same module
    internal var internalProperty = "Internal"
    
    // Private property - accessible only within this class
    private var privateProperty = "Private"
    
    // File-private property - accessible only within this file
    fileprivate var filePrivateProperty = "File Private"
    
    public init() {}
    
    // Public method - accessible from any module
    public func publicMethod() {
        print("Public method")
    }
    
    // Private method - accessible only within this class
    private func privateMethod() {
        print("Private method")
    }
}

// MARK: - Type Methods and Properties

class Math {
    // Type property (static property)
    static let pi = 3.14159
    
    // Type method (static method)
    static func calculateCircumference(radius: Double) -> Double {
        return 2 * pi * radius
    }
    
    // Type method that can be overridden by subclasses
    class func calculateArea(radius: Double) -> Double {
        return pi * radius * radius
    }
}

// Subclass that overrides a class method
class AdvancedMath: Math {
    // Override the class method
    override class func calculateArea(radius: Double) -> Double {
        // Add some extra precision
        return Double.pi * radius * radius
    }
}

// MARK: - Deinitializers

class ResourceManager {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    // Called when an instance is deallocated
    deinit {
        print("\(name) is being deinitialized")
    }
    
    func performTask() {
        print("\(name) is performing a task")
    }
}

// MARK: - Main function to demonstrate usage

func main() {
    print("Swift Object-Oriented Programming")
    print("--------------------------------")
    
    // Basic class usage
    print("\nBasic Class Usage:")
    let animal = Animal(name: "Generic Animal", age: 5)
    print(animal.makeSound())
    print(animal.eat(food: "food"))
    
    // Inheritance
    print("\nInheritance:")
    let dog = Dog(name: "Buddy", age: 3, breed: "Golden Retriever")
    print("Dog: \(dog.name), Age: \(dog.age), Breed: \(dog.breed)")
    print(dog.makeSound())
    print(dog.fetch())
    
    let cat = Cat(name: "Whiskers", age: 2, isIndoor: true)
    print("Cat: \(cat.name), Age: \(cat.age), Indoor: \(cat.isIndoor)")
    print(cat.makeSound())
    print(cat.purr())
    
    // Properties
    print("\nProperties:")
    let temp = Temperature(celsius: 25)
    print("Celsius: \(temp.celsius)°C")
    print("Fahrenheit: \(temp.fahrenheit)°F")
    print("Kelvin: \(temp.kelvin)K")
    
    // Change temperature in Fahrenheit
    temp.fahrenheit = 68
    print("After changing Fahrenheit:")
    print("Celsius: \(temp.celsius)°C")
    print("Fahrenheit: \(temp.fahrenheit)°F")
    print("Kelvin: \(temp.kelvin)K")
    
    // Lazy property
    print("\nLazy Property:")
    print(temp.description)
    
    // Type methods and properties
    print("\nType Methods and Properties:")
    print("Pi: \(Math.pi)")
    print("Circle circumference (radius 5): \(Math.calculateCircumference(radius: 5))")
    print("Circle area (radius 5): \(Math.calculateArea(radius: 5))")
    print("Advanced circle area (radius 5): \(AdvancedMath.calculateArea(radius: 5))")
    
    // Deinitializers
    print("\nDeinitializers:")
    do {
        // Create a resource manager that will be deallocated when this scope ends
        let manager = ResourceManager(name: "Resource Manager")
        manager.performTask()
    }
    print("After resource manager scope")
}

// Call the main function
main() 