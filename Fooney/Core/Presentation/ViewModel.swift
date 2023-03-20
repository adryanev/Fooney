//
//  Contracts.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import Foundation
import SwiftUI

public protocol ViewModel: ObservableObject {
    var router: Router? { get }
}
