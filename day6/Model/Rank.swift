//
//  Rank.swift
//  day6
//
//  Created by Doeun Kwon on 2024-09-17.
//

import Foundation

enum Rank: Int, CaseIterable, Comparable {

    case two = 2
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
    
    static func < (lhs: Rank, rhs: Rank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
}
