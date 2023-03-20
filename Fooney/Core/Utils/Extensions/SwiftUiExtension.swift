//
//  SwiftUiExtension.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 20/03/23.
//

import SwiftUI

extension Binding {
    
        /// ### Example of use
        ///     struct ContentView: View {
        ///         @State private var name = ""
        ///
        ///         var body: some View {
        ///             TextField("Enter name:", text: $name.onChange(nameChanged))
        ///         }
        ///
        ///         func nameChanged(to value: String) {
        ///             print("Name changed to \(name)!")
        ///         }
        ///     }
        ///
    public func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: {
                self.wrappedValue
            }, set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
