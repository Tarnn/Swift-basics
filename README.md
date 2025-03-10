# Swift Learning Project

This is a simple project to help you learn Swift syntax and concepts for your interview preparation.

## Project Structure

- `src/SwiftBasics.swift`: A comprehensive file containing examples of Swift syntax and features
- `src/ObjectOriented.swift`: Examples of Swift's object-oriented programming features
- `src/FunctionalProgramming.swift`: Examples of Swift's functional programming features
- `src/Concurrency.swift`: Examples of Swift's concurrency features
- `src/InterviewQuestions.swift`: Common coding interview questions and solutions in Swift

## How to Use This Project

### Running Swift on Windows

Swift is primarily designed for macOS and iOS development, but it can be used on Windows. Here are your options:

#### Option 1: Install Swift for Windows

1. Download the Swift for Windows installer from [Swift.org](https://swift.org/download/)
2. Install using the Windows installer (.exe)
3. Add Swift to your PATH environment variable
4. Run Swift files using:

```bash
swift src/SwiftBasics.swift
```

#### Option 2: Use Windows Package Manager (WinGet)

If you have WinGet installed, you can install Swift with:

```bash
winget install Swift.Toolchain
```

#### Option 3: Use Online Swift Playgrounds (Recommended for Beginners)

If you're having trouble with Swift installation on Windows, online Swift playgrounds are the easiest option:

1. [Swift Online Playground](https://online.swiftplayground.run/)
2. [Replit Swift](https://replit.com/languages/swift)
3. [SwiftFiddle](https://swiftfiddle.com/)

Simply copy the code from the Swift files and paste it into these online environments to run and experiment.

### Running Swift Files

If Swift is installed and available in your PATH, you can run the Swift files using:

```bash
swift src/SwiftBasics.swift
swift src/ObjectOriented.swift
swift src/FunctionalProgramming.swift
swift src/InterviewQuestions.swift
```

Note: The `Concurrency.swift` file uses the `@main` attribute and needs to be compiled before running:

```bash
swiftc src/Concurrency.swift -o concurrency
./concurrency
```

If Swift is installed but not in your PATH, you'll need to find the Swift executable and run it with the full path:

```bash
"C:\path\to\swift.exe" src/SwiftBasics.swift
```

## Key Swift Concepts Covered

### Basic Syntax (`SwiftBasics.swift`)

1. **Variables and Constants**
   - `var` for variables (can be changed)
   - `let` for constants (cannot be changed)
   - Type annotations

2. **Basic Data Types**
   - Strings
   - Numbers (Int, Double)
   - Booleans
   - Arrays
   - Dictionaries
   - Sets

3. **Control Flow**
   - If-else statements
   - Switch statements
   - For loops
   - While loops

4. **Functions**
   - Basic functions
   - Multiple parameters
   - Default parameter values
   - Variadic parameters

5. **Optionals**
   - Optional declaration (`?`)
   - Optional binding (`if let`)
   - Nil coalescing operator (`??`)

6. **Classes and Structures**
   - Basic implementation
   - Properties and methods

7. **Enumerations**
   - Basic enums
   - Enums with associated values

8. **Protocols**
   - Protocol definition
   - Protocol implementation

9. **Extensions**
   - Extending existing types

10. **Error Handling**
    - Defining errors
    - Throwing errors
    - Try-catch blocks

11. **Closures**
    - Basic closures
    - Closure syntax

### Object-Oriented Programming (`ObjectOriented.swift`)

1. **Classes and Structures**
   - Defining structures
   - Defining classes
   - Properties and methods
   - Initialization

2. **Inheritance**
   - Subclassing
   - Overriding methods
   - Calling superclass methods

3. **Properties**
   - Stored properties
   - Computed properties
   - Property observers
   - Lazy properties

4. **Access Control**
   - Public, internal, private, fileprivate

5. **Type Methods and Properties**
   - Static methods and properties
   - Class methods

6. **Deinitializers**
   - Cleanup when objects are deallocated

### Functional Programming (`FunctionalProgramming.swift`)

1. **Higher-Order Functions**
   - Map
   - Filter
   - Reduce
   - FlatMap/CompactMap

2. **Function Composition**
   - Combining functions

3. **Currying**
   - Transforming multi-parameter functions

4. **Lazy Evaluation**
   - Deferring computation until needed

### Concurrency (`Concurrency.swift`)

1. **Async/Await**
   - Basic asynchronous functions
   - Error handling with async functions

2. **Async Sequences**
   - Creating and iterating over async sequences

3. **Tasks**
   - Creating and managing tasks
   - Task priorities and cancellation

4. **Task Groups**
   - Parallel execution of multiple tasks

5. **Actors**
   - Thread-safe shared mutable state

6. **Async Let Bindings**
   - Concurrent execution of multiple async operations

### Interview Questions (`InterviewQuestions.swift`)

1. **String Manipulation**
   - Reversing strings
   - Checking palindromes
   - Finding non-repeating characters
   - Checking anagrams

2. **Array Problems**
   - Maximum subarray sum
   - Two Sum
   - Merging sorted arrays
   - Finding missing numbers

3. **Linked List Problems**
   - Reversing linked lists
   - Detecting cycles
   - Finding middle nodes
   - Merging sorted lists

4. **Tree Problems**
   - Tree traversals
   - Checking balanced trees
   - Finding tree depth
   - Validating binary search trees

5. **Dynamic Programming**
   - Fibonacci sequence
   - Climbing stairs
   - Longest increasing subsequence
   - Coin change

6. **Sorting and Searching**
   - Quicksort
   - Binary search
   - Finding kth largest element
   - Searching in rotated arrays

7. **Graph Problems**
   - Breadth-first search (BFS)
   - Depth-first search (DFS)
   - Cycle detection
   - Shortest path (Dijkstra's algorithm)

## Learning Strategy

1. Start with `SwiftBasics.swift` to understand the fundamental syntax
2. Move on to `ObjectOriented.swift` to learn about Swift's OOP features
3. Explore `FunctionalProgramming.swift` to understand Swift's functional programming capabilities
4. Study `Concurrency.swift` to learn about modern Swift concurrency
5. Practice with `InterviewQuestions.swift` to prepare for coding interviews
6. Modify the examples to experiment with different values and behaviors
7. Try to write your own functions and types using the patterns shown

## Additional Resources

- [Swift.org Documentation](https://swift.org/documentation/)
- [Apple's Swift Programming Language Guide](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)
- [Swift by Example](http://brettbukowski.github.io/SwiftExamples/)
- [Hacking with Swift](https://www.hackingwithswift.com/)
- [Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club)
- [Swift Evolution](https://github.com/apple/swift-evolution)
- [Swift for Windows Documentation](https://swiftforwindows.github.io/) (Windows-specific resources)

 