//
//  Card.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import UIKit

struct Card: Equatable, Hashable, Comparable {
    
    let suit: Suit.RawValue
    let rank: Rank.RawValue
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.suit == rhs.suit && lhs.rank == rhs.rank)
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
    
}
