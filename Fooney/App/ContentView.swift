//
//  ContentView.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 18/03/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var recogd: ModelObserable = .shared
    var body: some View {
        VStack {
            Text(recogd.showedEmoji)
            Text(recogd.showedQuote)
            WrappingView()
        }
        .environmentObject(recogd)
    }
}

struct WrappingView: View {
    @EnvironmentObject var recogd: ModelObserable

    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
