//
//  Destination.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import Foundation

public enum Destination {
    case forum
    case leaderboard
    case quote
}

extension Destination: Identifiable {
    public var id: Int {
        switch self {
        case .forum: return 1
        case .leaderboard: return 2
        case .quote: return 3
        }
    }
}
