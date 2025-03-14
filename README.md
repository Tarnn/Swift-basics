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
4. Run Swift files using: `swift src/SwiftBasics.swift`

#### Option 2: Use Windows Package Manager (WinGet)

If you have WinGet installed, you can install Swift with:

`winget install Swift.Toolchain`

#### Option 3: Use Online Swift Playgrounds (Recommended for Beginners)

If you're having trouble with Swift installation on Windows, online Swift playgrounds are the easiest option:

1. [Swift Online Playground](https://online.swiftplayground.run/)
2. [Replit Swift](https://replit.com/languages/swift)
3. [SwiftFiddle](https://swiftfiddle.com/)

Simply copy the code from the Swift files and paste it into these online environments to run and experiment.

### Running Swift Files

If Swift is installed and available in your PATH, you can run the Swift files using:

```
swift src/SwiftBasics.swift
swift src/ObjectOriented.swift
swift src/FunctionalProgramming.swift
swift src/InterviewQuestions.swift
```

Note: The `Concurrency.swift` file uses the `@main` attribute and needs to be compiled before running:

```
swiftc src/Concurrency.swift -o concurrency
./concurrency
```

## Key Swift Concepts Covered

### Basic Syntax (SwiftBasics.swift)

1. **Variables and Constants**
   - `var` for variables (can be changed)
   - `let` for constants (cannot be changed)
   - Type annotations

2. **Basic Data Types**
   - Strings, Numbers, Booleans
   - Arrays, Dictionaries, Sets

3. **Control Flow**
   - If-else statements, Switch statements
   - For loops, While loops

4. **Functions**
   - Basic functions, Multiple parameters
   - Default parameter values, Variadic parameters

5. **Optionals**
   - Optional declaration, Optional binding
   - Nil coalescing operator

6. **Classes and Structures**
   - Basic implementation, Properties and methods

7. **Enumerations, Protocols, Extensions**

8. **Error Handling and Closures**

### Object-Oriented Programming (ObjectOriented.swift)

- Classes, Structures, Inheritance
- Properties (Stored, Computed, Lazy)
- Access Control, Type Methods, Deinitializers

### Functional Programming (FunctionalProgramming.swift)

- Higher-Order Functions (Map, Filter, Reduce)
- Function Composition, Currying, Lazy Evaluation

### Concurrency (Concurrency.swift)

- Async/Await, Async Sequences
- Tasks, Task Groups, Actors
- Async Let Bindings

### Interview Questions (InterviewQuestions.swift)

- String Manipulation, Array Problems
- Linked List Problems, Tree Problems
- Dynamic Programming, Sorting and Searching
- Graph Problems

## Learning Strategy

1. Start with `SwiftBasics.swift` to understand the fundamental syntax
2. Move on to `ObjectOriented.swift` to learn about Swift's OOP features
3. Explore `FunctionalProgramming.swift` to understand Swift's functional programming capabilities
4. Study `Concurrency.swift` to learn about modern Swift concurrency
5. Practice with `InterviewQuestions.swift` to prepare for coding interviews

## Additional Resources

- [Swift.org Documentation](https://swift.org/documentation/)
- [Apple's Swift Programming Language Guide](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/)
- [Swift by Example](http://brettbukowski.github.io/SwiftExamples/)
- [Hacking with Swift](https://www.hackingwithswift.com/)
- [Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club)
- [Swift for Windows Documentation](https://swiftforwindows.github.io/) 