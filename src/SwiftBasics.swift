// SwiftBasics.swift
// A basic Swift file to learn Swift syntax

// MARK: - Variables and Constants

// Variables (can be changed)
var greeting = "Hello, Swift!"
var age = 30
var height = 175.5

// Constants (cannot be changed after initialization)
let pi = 3.14159
let daysInWeek = 7

// Type annotations (explicit type declaration)
var name: String = "John"
var isActive: Bool = true
var score: Int = 100
var temperature: Double = 23.5

// MARK: - Basic Data Types

// String
let message = "Welcome to Swift!"
let multilineString = """
This is a multiline string.
It can span multiple lines.
Swift preserves the line breaks.
"""

// Numbers
let integer: Int = 42
let decimal: Double = 42.5
let scientific: Double = 3.14e2 // 314.0

// Boolean
let isEnabled = true
let isDisabled = false

// MARK: - Collections

// Arrays
var fruits = ["Apple", "Banana", "Orange"]
var numbers: [Int] = [1, 2, 3, 4, 5]

// Dictionaries
var person = [
    "name": "Alice",
    "age": "25",
    "occupation": "Engineer"
]

// Sets
var uniqueNumbers: Set<Int> = [1, 2, 3, 4, 5]

// MARK: - Control Flow

// If-else statement
func checkAge(age: Int) {
    if age < 18 {
        print("You are a minor")
    } else if age >= 18 && age < 65 {
        print("You are an adult")
    } else {
        print("You are a senior")
    }
}

// Switch statement
func describeNumber(number: Int) {
    switch number {
    case 0:
        print("Zero")
    case 1...9:
        print("Single digit")
    case 10...99:
        print("Double digit")
    default:
        print("Large number")
    }
}

// For loops
func countToFive() {
    for i in 1...5 {
        print(i)
    }
}

// While loops
func countDownFromFive() {
    var count = 5
    while count > 0 {
        print(count)
        count -= 1
    }
}

// MARK: - Functions

// Basic function
func greet(person: String) -> String {
    return "Hello, \(person)!"
}

// Function with multiple parameters
func calculateArea(width: Double, height: Double) -> Double {
    return width * height
}

// Function with default parameter values
func greetWithDefault(person: String, greeting: String = "Hello") -> String {
    return "\(greeting), \(person)!"
}

// Variadic parameters
func sum(_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

// MARK: - Optionals

// Optional declaration
var optionalName: String?
var optionalAge: Int? = 30

// Optional binding
func printName() {
    if let name = optionalName {
        print("Name: \(name)")
    } else {
        print("Name is nil")
    }
}

// Nil coalescing operator
func getDisplayName() -> String {
    let displayName = optionalName ?? "Anonymous"
    return displayName
}

// MARK: - Classes and Structures

// Structure
struct Point {
    var x: Double
    var y: Double
    
    func distanceFromOrigin() -> Double {
        return sqrt(x*x + y*y)
    }
}

// Class
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func introduce() -> String {
        return "Hi, I'm \(name) and I'm \(age) years old."
    }
}

// MARK: - Enumerations

enum Direction {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// Enum with associated values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

// MARK: - Protocols

protocol Vehicle {
    var numberOfWheels: Int { get }
    func startEngine() -> String
}

struct Car: Vehicle {
    var numberOfWheels: Int = 4
    
    func startEngine() -> String {
        return "Vroom!"
    }
}

// MARK: - Extensions

extension Int {
    func squared() -> Int {
        return self * self
    }
}

// MARK: - Error Handling

enum MathError: Error {
    case divisionByZero
}

func divide(_ a: Int, by b: Int) throws -> Int {
    if b == 0 {
        throw MathError.divisionByZero
    }
    return a / b
}

// Using try-catch
func performDivision() {
    do {
        let result = try divide(10, by: 2)
        print("Result: \(result)")
    } catch MathError.divisionByZero {
        print("Error: Cannot divide by zero")
    } catch {
        print("An unknown error occurred")
    }
}

// MARK: - Closures

let simpleClosure = { print("This is a closure") }

let multiply: (Int, Int) -> Int = { a, b in
    return a * b
}

// MARK: - Main function to demonstrate usage

func main() {
    print("Learning Swift Basics")
    print("---------------------")
    
    print("\nVariables and Constants:")
    print("Greeting: \(greeting)")
    print("Pi: \(pi)")
    
    print("\nCollections:")
    print("Fruits: \(fruits)")
    print("Person: \(person)")
    
    print("\nFunctions:")
    print(greet(person: "Swift Learner"))
    print("Area: \(calculateArea(width: 10, height: 5))")
    print("Sum: \(sum(1, 2, 3, 4, 5))")
    
    print("\nOptionals:")
    optionalName = "John"
    printName()
    print("Display name: \(getDisplayName())")
    
    print("\nStructures and Classes:")
    let point = Point(x: 3, y: 4)
    print("Distance from origin: \(point.distanceFromOrigin())")
    
    let person = Person(name: "Alice", age: 28)
    print(person.introduce())
    
    print("\nEnumerations:")
    let direction = Direction.north
    print("Direction: \(direction)")
    
    print("\nClosures:")
    simpleClosure()
    print("5 × 6 = \(multiply(5, 6))")
    
    print("\nError Handling:")
    performDivision()
    
    print("\nExtensions:")
    print("5 squared is \(5.squared())")
}

// Call the main function
main() 