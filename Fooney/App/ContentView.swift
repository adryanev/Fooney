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
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            Image("CameraShape")
            PopUpView()
                .offset(x: 0, y: -250)
        }
        .environmentObject(recogd)
    }
}

struct WrappingView: View {
    @EnvironmentObject var recogd: ModelObserable

    var body: some View {
        ZStack {
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
