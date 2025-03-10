// Concurrency.swift
// Examples of Swift's concurrency features

import Foundation

// MARK: - Basic Asynchronous Functions

// Simple async function
func fetchUserName() async -> String {
    // Simulate network delay
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
    return "John Doe"
}

// Async function that can throw errors
enum NetworkError: Error {
    case badConnection
    case serverError(code: Int)
    case notFound
}

func fetchUserData(id: Int) async throws -> [String: String] {
    // Simulate network delay
    try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
    
    // Simulate error for certain IDs
    if id < 0 {
        throw NetworkError.badConnection
    } else if id == 0 {
        throw NetworkError.notFound
    } else if id > 1000 {
        throw NetworkError.serverError(code: 500)
    }
    
    // Return simulated user data
    return [
        "id": "\(id)",
        "name": "User \(id)",
        "email": "user\(id)@example.com"
    ]
}

// MARK: - Async/Await

func demonstrateAsyncAwait() async {
    print("\n--- Async/Await Examples ---")
    
    // Basic await
    print("Fetching user name...")
    let userName = await fetchUserName()
    print("User name: \(userName)")
    
    // Try-await with error handling
    print("\nFetching user data...")
    do {
        let userData = try await fetchUserData(id: 42)
        print("User data: \(userData)")
    } catch NetworkError.badConnection {
        print("Error: Bad connection")
    } catch NetworkError.notFound {
        print("Error: User not found")
    } catch NetworkError.serverError(let code) {
        print("Error: Server error with code \(code)")
    } catch {
        print("Unknown error: \(error)")
    }
    
    // Intentionally trigger an error
    print("\nFetching invalid user data...")
    do {
        let userData = try await fetchUserData(id: 0)
        print("User data: \(userData)")
    } catch {
        print("Error occurred: \(error)")
    }
}

// MARK: - Async Sequences

// A simple async sequence that generates numbers
struct NumberGenerator: AsyncSequence {
    typealias Element = Int
    let upperBound: Int
    
    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1
        let upperBound: Int
        
        mutating func next() async throws -> Int? {
            guard current <= upperBound else {
                return nil
            }
            
            // Simulate some async work
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
            
            let result = current
            current += 1
            return result
        }
    }
    
    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(upperBound: upperBound)
    }
}

func demonstrateAsyncSequences() async {
    print("\n--- Async Sequences Examples ---")
    
    print("Generating numbers asynchronously:")
    let numberGenerator = NumberGenerator(upperBound: 5)
    
    // Iterate over async sequence
    for try await number in numberGenerator {
        print("Generated number: \(number)")
    }
}

// MARK: - Task and TaskGroup

// Function to demonstrate basic Task usage
func demonstrateTasks() async {
    print("\n--- Task Examples ---")
    
    // Create and run a task
    print("Starting a task...")
    let task = Task {
        // Simulate work
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return "Task completed"
    }
    
    // Wait for the task to complete and get its result
    let result = await task.value
    print(result)
    
    // Task with priority
    print("\nStarting a high priority task...")
    let highPriorityTask = Task(priority: .high) {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return "High priority task completed"
    }
    
    print(await highPriorityTask.value)
    
    // Cancellable task
    print("\nStarting a cancellable task...")
    let cancellableTask = Task {
        var counter = 0
        while !Task.isCancelled && counter < 10 {
            // Check for cancellation
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
            counter += 1
            print("Task progress: \(counter)/10")
            
            // Simulate cancellation after some progress
            if counter == 3 {
                print("Cancelling task...")
                cancellableTask.cancel()
            }
        }
        
        if Task.isCancelled {
            return "Task was cancelled"
        } else {
            return "Task completed fully"
        }
    }
    
    print(await cancellableTask.value)
}

// Function to demonstrate TaskGroup
func fetchMultipleUserData(ids: [Int]) async -> [[String: String]] {
    var results: [[String: String]] = []
    
    // Use a task group to fetch multiple users in parallel
    await withTaskGroup(of: [String: String].self) { group in
        for id in ids {
            group.addTask {
                do {
                    return try await fetchUserData(id: id)
                } catch {
                    return ["id": "\(id)", "error": "\(error)"]
                }
            }
        }
        
        // Collect results as they complete
        for await result in group {
            results.append(result)
        }
    }
    
    return results
}

func demonstrateTaskGroups() async {
    print("\n--- Task Group Examples ---")
    
    print("Fetching multiple users in parallel...")
    let userIds = [5, 10, 15]
    let results = await fetchMultipleUserData(ids: userIds)
    
    for result in results {
        print("User: \(result)")
    }
}

// MARK: - Actors

// Define an actor to safely manage shared mutable state
actor Counter {
    private var value: Int = 0
    
    func increment() -> Int {
        value += 1
        return value
    }
    
    func decrement() -> Int {
        value -= 1
        return value
    }
    
    func getValue() -> Int {
        return value
    }
}

func demonstrateActors() async {
    print("\n--- Actor Examples ---")
    
    // Create a shared counter
    let counter = Counter()
    
    print("Working with a shared counter actor...")
    
    // Access the actor from multiple concurrent tasks
    async let increment1 = counter.increment()
    async let increment2 = counter.increment()
    async let increment3 = counter.increment()
    
    // Wait for all operations to complete
    let results = await [increment1, increment2, increment3]
    print("Increment results: \(results)")
    
    // Get the final value
    let finalValue = await counter.getValue()
    print("Final counter value: \(finalValue)")
    
    // Demonstrate actor isolation
    print("\nDemonstrating actor isolation...")
    
    // Create multiple tasks that access the same actor
    await withTaskGroup(of: Void.self) { group in
        for i in 1...5 {
            group.addTask {
                if i % 2 == 0 {
                    let value = await counter.increment()
                    print("Task \(i) incremented counter to \(value)")
                } else {
                    let value = await counter.decrement()
                    print("Task \(i) decremented counter to \(value)")
                }
                
                // Simulate some work
                try? await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
            }
        }
    }
    
    // Get the final value after all tasks
    let finalCounterValue = await counter.getValue()
    print("Final counter value after all tasks: \(finalCounterValue)")
}

// MARK: - Async Let Bindings

func demonstrateAsyncLet() async {
    print("\n--- Async Let Examples ---")
    
    print("Fetching user data concurrently...")
    
    // Start multiple async operations concurrently
    async let userName = fetchUserName()
    async let userData = try? fetchUserData(id: 42)
    
    // Wait for both to complete
    let name = await userName
    let data = await userData ?? [:]
    
    print("User name: \(name)")
    print("User data: \(data)")
    
    // More complex example with multiple async operations
    print("\nFetching multiple resources concurrently...")
    
    async let user1 = try? fetchUserData(id: 1)
    async let user2 = try? fetchUserData(id: 2)
    async let user3 = try? fetchUserData(id: 3)
    
    // Process results as they become available
    if let userData1 = await user1 {
        print("User 1: \(userData1)")
    }
    
    if let userData2 = await user2 {
        print("User 2: \(userData2)")
    }
    
    if let userData3 = await user3 {
        print("User 3: \(userData3)")
    }
}

// MARK: - Main function to demonstrate usage

@main
struct ConcurrencyExamples {
    static func main() async {
        print("Swift Concurrency")
        print("----------------")
        
        // Demonstrate async/await
        await demonstrateAsyncAwait()
        
        // Demonstrate async sequences
        await demonstrateAsyncSequences()
        
        // Demonstrate tasks
        await demonstrateTasks()
        
        // Demonstrate task groups
        await demonstrateTaskGroups()
        
        // Demonstrate actors
        await demonstrateActors()
        
        // Demonstrate async let
        await demonstrateAsyncLet()
        
        print("\nAll concurrency examples completed!")
    }
} 