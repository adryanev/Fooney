//
//  DiContainer.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 18/03/23.
//

import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()
    var container: Container {
        get {
            guard let returned = _container else {
                return buildContainer()
            }
            return returned
        }
        set {
            _container = newValue
        }
    }

    private var _container: Container?

    private func buildContainer() -> Container {
        let container = Container()
        return container
    }
}
