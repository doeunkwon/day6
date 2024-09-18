//
//  SessionTests.swift
//  day6Tests
//
//  Created by Doeun Kwon on 2024-09-18.
//

import XCTest
@testable import day6

final class SessionTests: XCTestCase {

    func testHighCard() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 9),
                    Card(suit: "♠️", rank: 3),
                    Card(suit: "♣️", rank: 5),
                    Card(suit: "♥️", rank: 7),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 0)
    }
    
    func testPair() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 2),
                    Card(suit: "♠️", rank: 3),
                    Card(suit: "♣️", rank: 5),
                    Card(suit: "♥️", rank: 7),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 1)
    }
    
    func testTwoPair() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 2),
                    Card(suit: "♠️", rank: 3),
                    Card(suit: "♣️", rank: 3),
                    Card(suit: "♥️", rank: 7),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 2)
    }
    
    func testThreeOfAKind() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 2),
                    Card(suit: "♠️", rank: 2),
                    Card(suit: "♣️", rank: 4),
                    Card(suit: "♥️", rank: 7),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 3)
    }
    
    func testStraight() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 3),
                    Card(suit: "♠️", rank: 4),
                    Card(suit: "♣️", rank: 5),
                    Card(suit: "♥️", rank: 6),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 4)
    }
    
    func testFlush() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♦️", rank: 4),
                    Card(suit: "♦️", rank: 6),
                    Card(suit: "♦️", rank: 8),
                    Card(suit: "♦️", rank: 10),
                    Card(suit: "♠️", rank: 12),
                    Card(suit: "♥️", rank: 14)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 5)
    }
    
    func testFullHouse() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 2),
                    Card(suit: "♠️", rank: 2),
                    Card(suit: "♣️", rank: 4),
                    Card(suit: "♥️", rank: 4),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 6)
    }
    
    func testFourOfAKind() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♥️", rank: 2),
                    Card(suit: "♠️", rank: 2),
                    Card(suit: "♣️", rank: 2),
                    Card(suit: "♥️", rank: 7),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♦️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 7)
    }
    
    func testStraightFlush() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 2),
                    Card(suit: "♦️", rank: 3),
                    Card(suit: "♦️", rank: 4),
                    Card(suit: "♦️", rank: 5),
                    Card(suit: "♦️", rank: 6),
                    Card(suit: "♠️", rank: 8),
                    Card(suit: "♥️", rank: 11)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 8)
    }
    
    func testRoyalFlush() {
        /// Arrange
        let session = Session()
        let hand = [Card(suit: "♦️", rank: 10),
                    Card(suit: "♦️", rank: 11),
                    Card(suit: "♦️", rank: 12),
                    Card(suit: "♦️", rank: 13),
                    Card(suit: "♦️", rank: 14),
                    Card(suit: "♠️", rank: 4),
                    Card(suit: "♥️", rank: 6)]
        /// Act
        let result = session.evaluateHandStrength(for: hand)
        /// Assert
        XCTAssertEqual(result, 9)
    }

}
