//
//  AppRouter.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import Foundation
import SwiftUI

final class AppRouter: Router {
    static let shared = AppRouter()
    
    private init() {}
    
    func route(to destination: Destination) -> AnyView {
        switch destination {
            case .forum: return LazyView(ForumView()).eraseToAnyView()
            case .quote: return LazyView(QuoteView()).eraseToAnyView()
            case .leaderboard: return LazyView(LeaderboardView()).eraseToAnyView()
        }
    }
}
