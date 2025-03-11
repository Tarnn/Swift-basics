import Foundation  // Required for Array.shuffle() and other Foundation utilities

// Enum defining the four suits of a standard deck, with String raw values for display
enum Suit: String, CaseIterable {
    case hearts = "Hearts", diamonds = "Diamonds", clubs = "Clubs", spades = "Spades"  // All suits on one line
}

// Enum defining the thirteen ranks of a standard deck, with String raw values for display
enum Rank: String, CaseIterable {
    case ace = "Ace", two = "2", three = "3", four = "4", five = "5", six = "6",
         seven = "7", eight = "8", nine = "9", ten = "10", jack = "Jack",
         queen = "Queen", king = "King"  // All ranks on one line
}

// Struct representing a single playing card with a rank and suit
struct Card {
    let rank: Rank  // The card's rank (e.g., .ace, .two), using the Rank enum
    let suit: Suit  // The card's suit (e.g., .hearts), using the Suit enum
    
    // Computed property returning the card's Blackjack value
    var value: Int {
        switch rank {
            case .ace: return 11  // Ace is worth 11, adjusted later in Hand if needed
            case .king, .jack, .queen: return 10  // Face cards are worth 10 in Blackjack
            case .ten: return 10  // "10" is explicitly worth 10
            case .two: return 2   // Numeric cards match their face value
            case .three: return 3
            case .four: return 4
            case .five: return 5
            case .six: return 6
            case .seven: return 7
            case .eight: return 8
            case .nine: return 9
        }
    }
    
    // Computed property for a human-readable card description (e.g., "Ace of Hearts")
    var description: String {
        return "\(rank.rawValue) of \(suit.rawValue)"  // Uses raw values for display
    }
}

// Class representing a deck of cards
class Deck {
    var cards: [Card] = []  // Array to store the deck's cards
    
    // Initializes a new deck by resetting it
    init() {
        resetDeck()
    }
    
    // Resets the deck to a full set of 52 shuffled cards
    func resetDeck() {
        if !cards.isEmpty {
            cards.removeAll()  // Clear any existing cards
        }

        // Generate all 52 cards by combining every suit with every rank
        cards = Suit.allCases.flatMap { suit in
         Rank.allCases.map { rank in 
          Card(rank: rank, suit: suit)
         }
        }
        cards.shuffle()  // Randomize the order of cards
    }
    
    // Deals and removes the top card from the deck; returns nil if empty
    func deal() -> Card? {
        return cards.isEmpty ? nil : cards.removeLast()
    }
}

// Class representing a player's or dealer's hand of cards
class Hand {
    var cards: [Card] = []  // Array to store cards in the hand
    
    // Computed property calculating the hand's total value, adjusting Aces as needed
    var value: Int {
        var total = cards.map { $0.value }.reduce(0, +)  // Sum all card values
        let aceCount = cards.filter { $0.rank == .ace }.count  // Count Aces in the hand
        
        var adjustedAces = 0  // Track how many Aces are adjusted from 11 to 1
        while total > 21 && adjustedAces < aceCount {  // Reduce total if over 21 and Aces remain
            total -= 10  // Change an Ace from 11 to 1 by subtracting 10
            adjustedAces += 1
        }
        return total
    }
    
    // Adds a card to the hand
    func add(card: Card) {
        cards.append(card)
    }
    
    // Removes all cards from the hand
    func clearHand() {
        cards.removeAll()
    }
    
    // Computed property for a human-readable hand description (e.g., "Ace of Spades, 2 of Hearts(Value: 13)")
    var description: String {
        return cards.map { $0.description }.joined(separator: ", ") + "(Value: \(value))"
    }
}

// Class managing a single Blackjack game
class BlackjackGame {
    let deck = Deck()         // The game's deck of cards
    let playerHand = Hand()   // The player's hand
    let dealerHand = Hand()   // The dealer's hand
    
    // Initializes a new game by dealing initial cards
    init() {
        deal()
    }
    
    // Deals two cards each to the player and dealer from the deck
    func deal() {
        if let card1 = deck.deal(), let card2 = deck.deal() {  // Deal player's initial cards
            playerHand.add(card: card1)
            playerHand.add(card: card2)
        }
        if let card1 = deck.deal(), let card2 = deck.deal() {  // Deal dealer's initial cards
            dealerHand.add(card: card1)
            dealerHand.add(card: card2)
        }
    }
    
    // Player takes an additional card from the deck
    func playerHit() {
        if let card = deck.deal() {
            playerHand.add(card: card)
        }
    }
    
    // Dealer plays according to Blackjack rules: hits until value is 17 or higher
    func dealerPlay() {
        while dealerHand.value < 17 {
            if let card = deck.deal() {
                dealerHand.add(card: card)
            }
        }
    }
    
    // Determines the winner based on hand values
    func determineWinner() -> String {
        let playerValue = playerHand.value
        let dealerValue = dealerHand.value
        
        // Check for busts first
        if playerValue > 21 {
            return "Player Busts! Dealer Wins"  // Player loses if they exceed 21
        }
        if dealerValue > 21 {
            return "Dealer Busts! Player Wins"  // Player wins if dealer exceeds 21 (fixed)
        }
        
        // Compare values if no busts
        if playerValue > dealerValue {
            return "Player wins with \(playerValue) against dealer: \(dealerValue)"  // Higher player value wins
        }
        if dealerValue > playerValue {
            return "Dealer wins with \(dealerValue) against \(playerValue)"  // Higher dealer value wins
        }
        return "Tie Game! \(playerValue)"  // Tie if values are equal
    }
    
    // Plays one round of Blackjack
    func play() {
        print("Player's hand: \(playerHand.description)")  // Display player's full hand
        print("Dealers first card: \(dealerHand.cards[0].description)")  // Show only dealer's first card
        
        if playerHand.value < 17 {  // Player hits if hand value is below 17 (simplified strategy)
            playerHit()
            print("Player hits: \(playerHand.description)")
        }
        
        dealerPlay()  // Dealer takes their turn
        print("Dealer's hand: \(dealerHand.description)")  // Show dealer's full hand
        print(determineWinner())  // Announce the winner
    }
    
    // Resets the game for a new round
    func restart() {
        deck.resetDeck()       // Reset deck to 52 shuffled cards
        playerHand.clearHand() // Clear player's hand
        dealerHand.clearHand() // Clear dealer's hand
        deal()                 // Deal new initial cards
    }
}

// Create a game instance and run it
let game = BlackjackGame()
game.play()           // Play the first round
game.restart()        // Reset the game state
print("\n ---- Playing Again! ---- \n")
game.play()           // Play a second round