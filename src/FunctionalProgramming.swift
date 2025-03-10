// FunctionalProgramming.swift
// Examples of Swift's functional programming features

// MARK: - Higher-Order Functions

// MARK: Map
// Transform each element in a collection

func demonstrateMap() {
    print("\n--- Map Examples ---")
    
    let numbers = [1, 2, 3, 4, 5]
    
    // Using map with a closure
    let doubled = numbers.map { number in
        return number * 2
    }
    print("Original: \(numbers)")
    print("Doubled: \(doubled)")
    
    // Shorter syntax with implicit parameter
    let squared = numbers.map { $0 * $0 }
    print("Squared: \(squared)")
    
    // Map with strings
    let names = ["john", "alice", "bob"]
    let capitalizedNames = names.map { $0.capitalized }
    print("Original names: \(names)")
    print("Capitalized: \(capitalizedNames)")
    
    // Map with optional values
    let optionalNumbers: [Int?] = [1, nil, 3, nil, 5]
    let unwrappedDoubled = optionalNumbers.map { $0 != nil ? $0! * 2 : nil }
    print("Optional numbers: \(optionalNumbers)")
    print("Unwrapped and doubled: \(unwrappedDoubled)")
    
    // CompactMap - removes nil values
    let nonNilDoubled = optionalNumbers.compactMap { $0 != nil ? $0! * 2 : nil }
    print("Non-nil doubled: \(nonNilDoubled)")
}

// MARK: Filter
// Keep only elements that satisfy a condition

func demonstrateFilter() {
    print("\n--- Filter Examples ---")
    
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    // Filter even numbers
    let evenNumbers = numbers.filter { number in
        return number % 2 == 0
    }
    print("Original: \(numbers)")
    print("Even numbers: \(evenNumbers)")
    
    // Shorter syntax
    let oddNumbers = numbers.filter { $0 % 2 != 0 }
    print("Odd numbers: \(oddNumbers)")
    
    // Filter with strings
    let names = ["John", "Alice", "Bob", "Anna", "Adam"]
    let namesStartingWithA = names.filter { $0.hasPrefix("A") }
    print("Names: \(names)")
    print("Names starting with A: \(namesStartingWithA)")
    
    // Combining filter with other operations
    let sumOfEvenNumbers = numbers.filter { $0 % 2 == 0 }.reduce(0, +)
    print("Sum of even numbers: \(sumOfEvenNumbers)")
}

// MARK: Reduce
// Combine all elements into a single value

func demonstrateReduce() {
    print("\n--- Reduce Examples ---")
    
    let numbers = [1, 2, 3, 4, 5]
    
    // Sum all numbers
    let sum = numbers.reduce(0) { result, number in
        return result + number
    }
    print("Numbers: \(numbers)")
    print("Sum: \(sum)")
    
    // Shorter syntax
    let product = numbers.reduce(1, *)
    print("Product: \(product)")
    
    // Reduce with strings
    let words = ["Swift", "is", "functional"]
    let sentence = words.reduce("") { result, word in
        return result.isEmpty ? word : result + " " + word
    }
    print("Words: \(words)")
    print("Sentence: \(sentence)")
    
    // More complex reduce example
    let maxNumber = numbers.reduce(Int.min) { max($0, $1) }
    print("Maximum number: \(maxNumber)")
    
    // Reduce into - more efficient for some operations
    let evenOddCounts = numbers.reduce(into: [String: Int]()) { result, number in
        let key = number % 2 == 0 ? "even" : "odd"
        result[key, default: 0] += 1
    }
    print("Even/odd counts: \(evenOddCounts)")
}

// MARK: FlatMap
// Flatten nested collections and transform elements

func demonstrateFlatMap() {
    print("\n--- FlatMap Examples ---")
    
    // Nested arrays
    let nestedArrays = [[1, 2, 3], [4, 5], [6, 7, 8, 9]]
    
    // Flatten the nested arrays
    let flattenedArray = nestedArrays.flatMap { $0 }
    print("Nested arrays: \(nestedArrays)")
    print("Flattened: \(flattenedArray)")
    
    // FlatMap with transformation
    let doubledAndFlattened = nestedArrays.flatMap { array in
        return array.map { $0 * 2 }
    }
    print("Doubled and flattened: \(doubledAndFlattened)")
    
    // FlatMap with optionals (now compactMap)
    let optionalNumbers = ["1", "2", "three", "4", "five"]
    let parsedNumbers = optionalNumbers.compactMap { Int($0) }
    print("String numbers: \(optionalNumbers)")
    print("Parsed numbers: \(parsedNumbers)")
}

// MARK: - Function Composition

// Create a function that applies multiple transformations
func compose<A, B, C>(_ f: @escaping (B) -> C, _ g: @escaping (A) -> B) -> (A) -> C {
    return { x in f(g(x)) }
}

func demonstrateFunctionComposition() {
    print("\n--- Function Composition Examples ---")
    
    // Simple functions
    func increment(_ x: Int) -> Int { return x + 1 }
    func double(_ x: Int) -> Int { return x * 2 }
    func square(_ x: Int) -> Int { return x * x }
    
    // Compose functions
    let incrementThenDouble = compose(double, increment)
    let doubleThenSquare = compose(square, double)
    let incrementThenDoubleThenSquare = compose(square, compose(double, increment))
    
    let number = 5
    print("Original number: \(number)")
    print("Increment then double: \(incrementThenDouble(number))")
    print("Double then square: \(doubleThenSquare(number))")
    print("Increment then double then square: \(incrementThenDoubleThenSquare(number))")
}

// MARK: - Currying
// Transform a function with multiple parameters into a sequence of functions

func curry<A, B, C>(_ function: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in function(a, b) } }
}

func demonstrateCurrying() {
    print("\n--- Currying Examples ---")
    
    // Original function
    func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    // Curried version
    let curriedMultiply = curry(multiply)
    
    // Create specialized functions
    let multiplyByTwo = curriedMultiply(2)
    let multiplyByTen = curriedMultiply(10)
    
    let number = 5
    print("Original number: \(number)")
    print("Multiplied by 2: \(multiplyByTwo(number))")
    print("Multiplied by 10: \(multiplyByTen(number))")
    
    // Another example with string formatting
    func format(_ format: String, _ value: String) -> String {
        return String(format: format, value)
    }
    
    let curriedFormat = curry(format)
    let formatAsCurrency = curriedFormat("$%@")
    let formatAsPercentage = curriedFormat("%@%%")
    
    print("Format '42' as currency: \(formatAsCurrency("42"))")
    print("Format '75' as percentage: \(formatAsPercentage("75"))")
}

// MARK: - Lazy Evaluation

func demonstrateLazyEvaluation() {
    print("\n--- Lazy Evaluation Examples ---")
    
    let numbers = Array(1...1000)
    
    // Without lazy, all operations are performed immediately
    print("Without lazy (first 5 results):")
    let firstFiveDoubledEvenNumbers = numbers
        .filter { $0 % 2 == 0 }
        .map { 
            print("Mapping \($0)")
            return $0 * 2 
        }
        .prefix(5)
    print(Array(firstFiveDoubledEvenNumbers))
    
    print("\nWith lazy (first 5 results):")
    let lazyFirstFiveDoubledEvenNumbers = numbers.lazy
        .filter { $0 % 2 == 0 }
        .map { 
            print("Lazy mapping \($0)")
            return $0 * 2 
        }
        .prefix(5)
    print(Array(lazyFirstFiveDoubledEvenNumbers))
}

// MARK: - Main function to demonstrate usage

func main() {
    print("Swift Functional Programming")
    print("--------------------------")
    
    demonstrateMap()
    demonstrateFilter()
    demonstrateReduce()
    demonstrateFlatMap()
    demonstrateFunctionComposition()
    demonstrateCurrying()
    demonstrateLazyEvaluation()
}

// Call the main function
main() 