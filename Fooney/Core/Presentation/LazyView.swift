//
//  LazyView.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    let build: () -> Content
    
    public init(_ build: @autoclosure @escaping () -> Content){
        self.build = build
    }
    
    public var body: Content {
        build()
    }
}
