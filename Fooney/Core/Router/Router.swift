//
//  Router.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import Foundation
import SwiftUI

public protocol Router {
    func route(to destination: Destination) -> AnyView
}
