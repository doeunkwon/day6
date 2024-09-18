//
//  Session.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import UIKit

class Session {
    
    let cardsPerRow: CGFloat = 4
    let spacingBetweenCards: CGFloat = 10
    var deck: [Card] = []
    var holeCards: [Card] = []
    var communityCards: [Card] = []
    
    func generateDeck() {
        deck.removeAll()
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                let card = Card(suit: suit.rawValue, rank: rank.rawValue)
                deck.append(card)
            }
        }
    }
    
    func addCardToPicked(_ card: Card) {
        guard holeCards.count + communityCards.count <= 7 else { return }
        if holeCards.count < 2 {
            holeCards.append(card)
        } else {
            communityCards.append(card)
        }
    }
    
    func removeCardFromPicked(_ card: Card) {
        if let index = holeCards.firstIndex(where: { $0 == card }) {
            holeCards.remove(at: index)
        } else if let index = communityCards.firstIndex(where: { $0 == card }) {
            communityCards.remove(at: index)
        }
    }

    func calculateOdds(numSimulations: Int) -> Double {
        
        print("My hole cards: \(holeCards)")
        print("Community cards: \(communityCards)")
        
        guard holeCards.count == 2 else {
            print("You need 2 hole cards to calculate odds.")
            return 0.0
        }
        
        guard (3...5).contains(communityCards.count) else {
            print("You need between 3 to 5 community cards to calculate odds.")
            return 0.0
        }

        var wins: Double = 0
        let poolDeck = generatePoolDeck(excluding: holeCards + communityCards)

        for _ in 0..<numSimulations {
            
            let remainingCards = drawRemainingCards(deck: poolDeck, count: 7 - (holeCards.count + communityCards.count))
            
            let yourHandStrength = evaluateHandStrength(for: holeCards + communityCards + remainingCards)
            
            let opponentHoleCards = drawRandomCards(from: poolDeck, count: 2)
            let opponentHandStrength = evaluateHandStrength(for: opponentHoleCards + communityCards + remainingCards)

            if yourHandStrength > opponentHandStrength {
                wins += 1
            } else if yourHandStrength == opponentHandStrength {
                wins += 0.5
            }
        }

        return wins / Double(numSimulations)
    }
    
    // MARK: - Helper Methods
    
    private func generatePoolDeck(excluding excludedCards: [Card]) -> [Card] {
        var deck = [Card]()
        for rank in Rank.allCases {
            for suit in Suit.allCases {
                let card = Card(suit: suit.rawValue, rank: rank.rawValue)
                if !excludedCards.contains(where: { $0.rank == card.rank && $0.suit == card.suit }) {
                    deck.append(card)
                }
            }
        }
        return deck
    }

    private func drawRandomCards(from deck: [Card], count: Int) -> [Card] {
        return Array(deck.shuffled().prefix(count))
    }
    
    private func drawRemainingCards(deck: [Card], count: Int) -> [Card] {
        guard count > 0 else { return [] }
        return drawRandomCards(from: deck, count: count)
    }
    
    // MARK: - Hand Evaluation Logic
    
    func evaluateHandStrength(for hand: [Card]) -> Int {
        let ranks = hand.compactMap { Rank(rawValue: $0.rank) }
        let rankCounts = Dictionary(grouping: ranks, by: { $0 }).mapValues { $0.count }
        
        let suits = hand.map { $0.suit }
        let suitCounts = Dictionary(grouping: suits, by: { $0 }).mapValues { $0.count }
        
        if isRoyalFlush(cards: hand) {
            return 9
        } else if isStraightFlush(cards: hand) {
            return 8
        } else if isFourOfAKind(rankCounts: rankCounts) {
            return 7
        } else if isFullHouse(rankCounts: rankCounts) {
            return 6
        } else if isFlush(suitCounts: suitCounts) {
            return 5
        } else if isStraight(ranks: ranks.map { $0.rawValue }) {
            return 4
        } else if isThreeOfAKind(rankCounts: rankCounts) {
            return 3
        } else if isTwoPair(rankCounts: rankCounts) {
            return 2
        } else if isPair(rankCounts: rankCounts) {
            return 1
        } else {
            return 0
        }
        
    }
    
    private func isPair(rankCounts: Dictionary<Rank, Int>) -> Bool { return rankCounts.values.contains(2) }
    
    private func isTwoPair(rankCounts: Dictionary<Rank, Int>) -> Bool { return rankCounts.values.filter { $0 == 2 }.count >= 2 }
    
    private func isThreeOfAKind(rankCounts: Dictionary<Rank, Int>) -> Bool { return rankCounts.values.contains(3) }
    
    private func isStraight(ranks: [Int]) -> Bool {
        
        let sortedRanks = Array(Set(ranks)).sorted()
        var consecutiveCount = 1
        
        for i in 1..<sortedRanks.count {
            if sortedRanks[i] == (sortedRanks[i-1] + 1) {
                consecutiveCount += 1
                if consecutiveCount == 5 {
                    return true
                }
            } else {
                consecutiveCount = 1
            }
        }
        
        return false
    }
    
    private func isFlush(suitCounts: Dictionary<String, Int>) -> Bool { return suitCounts.values.contains(5) }
    
    private func isFullHouse(rankCounts: Dictionary<Rank, Int>) -> Bool { return isThreeOfAKind(rankCounts: rankCounts) && isPair(rankCounts: rankCounts) }
    
    private func isFourOfAKind(rankCounts: Dictionary<Rank, Int>) -> Bool { return rankCounts.values.contains(4) }
    
    private func isStraightFlush(cards: [Card]) -> Bool {
        
        let sortedCards = Array(Set(cards)).sorted()
        var consecutiveCount = 1
        
        for i in 1..<sortedCards.count {
            let currCard = sortedCards[i]
            let prevCard = sortedCards[i-1]
            let isIncrement = currCard.rank == (prevCard.rank + 1)
            let isSameSuit = currCard.suit == prevCard.suit
            if isIncrement && isSameSuit {
                consecutiveCount += 1
                if consecutiveCount == 5 {
                    return true
                }
            } else {
                consecutiveCount = 1
            }
        }
        
        return false
    }
    
    private func isRoyalFlush(cards: [Card]) -> Bool {
        
        let sortedCards = Array(Set(cards)).sorted()
        var lastFiveSortedCards: [Card] = []
        
        if sortedCards.count >= 5 {
            lastFiveSortedCards = sortedCards.suffix(5)
        } else {
            return false
        }
        
        if lastFiveSortedCards[0].rank != 10 {
            return false
        }
        
        for i in 1..<5 {
            let currCard = lastFiveSortedCards[i]
            let prevCard = lastFiveSortedCards[i-1]
            let isIncrement = currCard.rank == (prevCard.rank + 1)
            let isSameSuit = currCard.suit == prevCard.suit
            if isIncrement && isSameSuit {
                if i == 4 {
                    return true
                }
            } else {
                break
            }
        }
        
        return false
    }
    
    
}
